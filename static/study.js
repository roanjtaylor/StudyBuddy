// The study chat under an open idea. Throw-away: the conversation lives in this page's
// memory (on the .study element) and is sent back with every question; the server stores
// nothing, and opening another idea or reloading starts it afresh.
//
// Events are delegated from the document, so a pane swapped in by map.js just works.
// The reply streams as server-sent events: status {text}, delta {text}, message {html, text}.
(function () {
  if (!window.md) return;
  var MARK = '<svg class="mark" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round"><path d="M12 3v18M3 12h18M5.6 5.6l12.8 12.8M18.4 5.6 5.6 18.4"></path></svg>';
  var frames = ['·', '✢', '✳', '✶', '✻', '✽', '✻', '✶', '✳', '✢'];

  function grow(box) { box.style.height = 'auto'; box.style.height = Math.min(box.scrollHeight, 176) + 'px'; }

  // Server-sent events from a fetch body; lines end in LF or CRLF.
  function readEvents(response, on) {
    var reader = response.body.getReader(), decoder = new TextDecoder(), buf = '';
    function handle(chunk) {
      var name = 'message', data = [];
      chunk.split(/\r?\n/).forEach(function (line) {
        if (line.indexOf('event:') === 0) name = line.slice(6).trim();
        else if (line.indexOf('data:') === 0) data.push(line.slice(5).trim());
      });
      if (data.length) { try { on(name, JSON.parse(data.join('\n'))); } catch (e) { on(name, {}); } }
    }
    return reader.read().then(function step(r) {
      if (r.done) { if (buf.trim()) handle(buf); return; }
      buf += decoder.decode(r.value, { stream: true });
      var parts = buf.split(/\r?\n\r?\n/);
      buf = parts.pop();
      parts.forEach(handle);
      return reader.read().then(step);
    });
  }

  function el(tag, cls, text) {
    var e = document.createElement(tag);
    if (cls) e.className = cls;
    if (text) e.textContent = text;
    return e;
  }

  // ---- Proposed edits: reviewed side by side ----
  // The idea on the left keeps its stored text, with what would be cut marked red; the right
  // column, in place of the chat, shows the idea as it would read, with what is new marked
  // green, under Approve / Reject. Either answer brings the chat back where it was.

  // Longest-common-subsequence diff of two arrays → [[' '|'-'|'+', item], …].
  function lcsDiff(x, y) {
    var n = x.length, m = y.length, i, j, t = [];
    for (i = 0; i <= n; i++) t.push(new Array(m + 1).fill(0));
    for (i = n - 1; i >= 0; i--) for (j = m - 1; j >= 0; j--)
      t[i][j] = x[i] === y[j] ? t[i + 1][j + 1] + 1 : Math.max(t[i + 1][j], t[i][j + 1]);
    var out = []; i = 0; j = 0;
    while (i < n && j < m) {
      if (x[i] === y[j]) { out.push([' ', x[i]]); i++; j++; }
      else if (t[i + 1][j] >= t[i][j + 1]) out.push(['-', x[i++]]);
      else out.push(['+', y[j++]]);
    }
    while (i < n) out.push(['-', x[i++]]);
    while (j < m) out.push(['+', y[j++]]);
    return out;
  }

  // Whole sentences diffed, as runs: [[' '|'-'|'+', text], …]. A sentence that changed at all
  // is struck whole and its replacement follows whole, so both stay readable; within a
  // changed stretch every struck sentence comes before the new ones.
  function sentences(s) {
    return s ? s.split(/(?<=[.!?]\s+)(?=\S)/).map(function (x) { return x.trimEnd(); }).filter(Boolean) : [];
  }
  function sentenceRuns(a, b) {
    var runs = [], del = [], add = [];
    function flush() {
      if (del.length) runs.push(['-', del.join(' ')]);
      if (add.length) runs.push(['+', add.join(' ')]);
      del = []; add = [];
    }
    lcsDiff(sentences(a), sentences(b)).forEach(function (r) {
      if (r[0] === '-') del.push(r[1]);
      else if (r[0] === '+') add.push(r[1]);
      else {
        flush();
        var last = runs[runs.length - 1];
        if (last && last[0] === ' ') last[1] += ' ' + r[1]; else runs.push([' ', r[1]]);
      }
    });
    flush();
    return runs;
  }

  // Each column shows one side of the diff: '-' is the stored text with its cuts marked,
  // '+' the proposed text with its additions marked.
  function oneSide(runs, side) { return runs.filter(function (r) { return r[0] === ' ' || r[0] === side; }); }

  // Plain text field: the element's own text becomes that side of the diff.
  function previewText(node, before, after, prefix, side) {
    node.textContent = '';
    if (prefix && (side === '-' ? before : after)) node.appendChild(document.createTextNode(prefix));
    // Text on several lines is compared line by line, and keeps its line breaks.
    var lines = /\n/.test(before + after);
    var runs = lines ? lcsDiff(before ? before.split('\n') : [], after ? after.split('\n') : [])
                     : sentenceRuns(before, after);
    oneSide(runs, side).forEach(function (r, i) {
      if (i) node.appendChild(document.createTextNode(lines ? '\n' : ' '));
      if (r[0] === ' ') node.appendChild(document.createTextNode(r[1]));
      else node.appendChild(el(r[0] === '-' ? 'del' : 'ins', '', r[1]));
    });
  }

  // The markdown body: unchanged lines render as usual; a changed line of plain prose that keeps
  // some of its sentences is marked sentence by sentence inside its own paragraph; anything
  // else (a rewritten paragraph, a new list, a table…) is marked as a whole block.
  // Private-use characters carry the marks through md.
  var DEL0 = '', DEL1 = '', INS0 = '', INS1 = '';
  var PLAIN = /^[^*`~\[|]*$/;
  // A line's markdown lead-in (bullet, number, heading, quote) stays outside the marks.
  function lead(l) { return /^\s*(?:(?:[-+]|\d+[.)]|#{1,6}|>)\s+)?/.exec(l)[0]; }
  function lineRuns(a, b) { return sentenceRuns(a.slice(lead(a).length), b.slice(lead(b).length)); }
  function mergeLine(a, b, side) {
    return lead(side === '-' ? a : b) + oneSide(lineRuns(a, b), side).map(function (r) {
      return r[0] === ' ' ? r[1] : r[0] === '-' ? DEL0 + r[1] + DEL1 : INS0 + r[1] + INS1;
    }).join(' ');
  }
  function marks(html) {
    return html.split(DEL0).join('<del>').split(DEL1).join('</del>').split(INS0).join('<ins>').split(INS1).join('</ins>');
  }
  function previewNotes(box, before, after, side) {
    var rows = lcsDiff(before ? before.split('\n') : [], after ? after.split('\n') : []), html = '', k = 0;
    // Lines that render together: a hunk with nothing on this side must not split a paragraph or list.
    var buf = [];
    function flush() { if (buf.length) html += marks(window.md.render(buf.join('\n'))); buf = []; }
    while (k < rows.length) {
      if (rows[k][0] === ' ') { buf.push(rows[k++][1]); continue; }
      var del = [], add = [];
      while (k < rows.length && rows[k][0] !== ' ') (rows[k][0] === '-' ? del : add).push(rows[k++][1]);
      var pair = del.length === add.length && del.every(function (d, i) {
        var e = add[i];
        return (d.trim() && e.trim() && PLAIN.test(d) && PLAIN.test(e) && lead(d) === lead(e) &&
                lineRuns(d, e).some(function (r) { return r[0] === ' '; })) || (!d.trim() && !e.trim());
      });
      var mine = side === '-' ? del : add;
      if (pair) del.forEach(function (d, i) { buf.push(mergeLine(d, add[i], side)); });
      else if (!mine.some(function (l) { return l.trim(); })) buf = buf.concat(mine);
      else {
        flush();
        html += '<div class="chg chg-' + (side === '-' ? 'del' : 'add') + '">' + window.md.render(mine.join('\n')) + '</div>';
      }
    }
    flush();
    box.innerHTML = html;
  }
  function draw(node, c, side) {
    node.hidden = !(side === '-' ? c.before : c.after);
    node.classList.add('previewing');
    if (c.field === 'body') previewNotes(node, c.before, c.after, side);
    else previewText(node, c.before, c.after, c.field === 'era' ? ' · ' : '', side);
  }

  // One review at a time: what is drawn on the idea, and the pane standing in for the chat.
  var shown = null;
  function holder(field) { return document.querySelector('.idea-main [data-field="' + field + '"]'); }
  // Take the review away. keepLeft: the idea itself has just been replaced, so leave it alone.
  function close(keepLeft) {
    if (!shown) return;
    if (!keepLeft) shown.saved.forEach(function (s) {
      s.node.innerHTML = s.html; s.node.hidden = s.hidden; s.node.classList.remove('previewing');
    });
    shown.review.remove();
    shown.side.classList.remove('reviewing');
    shown = null;
  }
  function restore() { close(false); }
  // After an approved edit the server's version replaces the idea; another idea does too.
  document.addEventListener('idea-swapped', function () { close(true); });

  // Put the proposal `p` up for review; `where` is the reply it came with, in the chat log.
  function review(p, form, pane, where) {
    var src = document.querySelector('.idea-main .node'), side = pane.parentNode, changes = p.changes || [];
    if (!src || !changes.length) return;
    restore();
    // The right column: the idea as it would read.
    var fresh = src.cloneNode(true), saved = [];
    fresh.querySelectorAll('h2, .artifact-list').forEach(function (x) { x.remove(); });
    changes.forEach(function (c) {
      var old = holder(c.field), neu = fresh.querySelector('[data-field="' + c.field + '"]');
      if (!old || !neu) return;
      saved.push({ node: old, html: old.innerHTML, hidden: old.hidden });
      draw(old, c, '-'); draw(neu, c, '+');
    });
    var card = el('section', 'review'), bar = el('div', 'review-bar'),
        yes = el('button', 'approve', '✓ Approve'), no = el('button', 'reject', '✕ Reject'), note = el('p', 'review-note quiet small');
    card.setAttribute('aria-label', 'Proposed edit');
    yes.type = 'button'; no.type = 'button';
    bar.appendChild(yes); bar.appendChild(no);
    card.appendChild(fresh); card.appendChild(note); card.appendChild(bar);
    side.appendChild(card); side.classList.add('reviewing');
    shown = { saved: saved, review: card, side: side };
    document.getElementById('idea').scrollIntoView({ block: 'start', behavior: 'smooth' });

    // Back to the chat, where it was, with a line under the reply saying what happened.
    function resume(text) {
      where.appendChild(el('p', 'quiet small proposal-note', text));
      var log = pane.querySelector('.study-log'); log.scrollTop = log.scrollHeight;
      pane.querySelector('textarea').focus();
    }
    no.onclick = function () { restore(); resume('Edit rejected. Nothing changed.'); };
    yes.onclick = function () {
      var chosen = {};
      changes.forEach(function (c) { chosen[c.field] = c.after; });
      yes.disabled = no.disabled = true; note.textContent = 'Applying…';
      var body = new URLSearchParams();
      body.set('map-name', form.elements['map-name'].value); body.set('here', form.elements.here.value);
      body.set('changes', JSON.stringify(chosen));
      fetch('/action/apply-edit', { method: 'POST', body: body })
        .then(function (r) { return r.json(); })
        .then(function (r) {
          if (!r.ok) throw new Error(r.error || 'The edit was not applied.');
          // Applied: the left column takes the stored version, and the chat comes back.
          if (!window.refreshIdea) { location.reload(); return; }
          return window.refreshIdea().then(
            function () { close(true); resume('Edit approved and applied.'); },
            function () { location.reload(); });
        })
        .catch(function (err) { yes.disabled = no.disabled = false; note.textContent = String(err.message || err); });
    };
  }

  function send(form) {
    var pane = form.closest('.study'), log = pane.querySelector('.study-log');
    var box = form.elements.text, text = box.value.trim();
    if (!text || form.classList.contains('busy')) return;
    var history = pane._history || (pane._history = []);

    var body = new URLSearchParams(new FormData(form));
    body.set('text', text);
    body.set('history', JSON.stringify(history));

    // The first question opens the pane to the height of the window, to give the answer room.
    if (!pane.classList.contains('grown')) {
      pane.style.height = pane.offsetHeight + 'px';
      pane.classList.add('grown');
      pane.offsetHeight;                      // settle the starting height, so the change animates
      pane.style.height = '';
      pane.scrollIntoView({ block: 'start', behavior: 'smooth' });
    }

    var mine = el('article', 'msg msg-you'), p = el('p', '', text);
    mine.appendChild(p); log.appendChild(mine);

    // The live reply: the mark, the words as they come, a status line while it works.
    var live = el('article', 'msg msg-buddy live');
    var mark = el('span', 'msg-mark'); mark.innerHTML = MARK;
    var activity = el('div', 'activity'), md_ = el('div', 'md'), status = el('p', 'dock-status');
    status.setAttribute('role', 'status');
    var cards = el('div', 'msg-artifacts'); cards.hidden = true;
    live.appendChild(mark); live.appendChild(activity); live.appendChild(md_); live.appendChild(cards); live.appendChild(status);
    log.appendChild(live);
    function scroll() { log.scrollTop = log.scrollHeight; }
    scroll();

    var t0 = Date.now(), i = 0, verb = 'Thinking', reply = '', timer = null;
    function tick() {
      status.innerHTML = '<span class="spin">' + frames[i++ % frames.length] + '</span> ' + verb + '… ' +
        Math.round((Date.now() - t0) / 1000) + 's';
    }
    tick(); timer = setInterval(tick, 130);
    var renderTimer = null;
    function render() { md_.innerHTML = window.md.render(reply); scroll(); }

    box.value = ''; grow(box);
    var send_ = form.querySelector('.dock-send:not(.dock-stop):not(.dock-clear)'), stop = form.querySelector('.dock-stop');
    var clear = form.querySelector('.dock-clear');
    form.classList.add('busy'); send_.hidden = true; stop.hidden = false; if (clear) clear.hidden = true;
    var ctl = new AbortController();
    stop.onclick = function () { ctl.abort(); };
    var final_ = null, proposals = [];
    // A proposed edit takes over both columns for review; the last one of a reply stands.
    function showProposals(where) {
      if (proposals.length) review(proposals[proposals.length - 1], form, pane, where);
      else scroll();
    }

    function done() {
      clearInterval(timer); if (renderTimer) clearTimeout(renderTimer);
      form.classList.remove('busy'); send_.hidden = false; stop.hidden = true;
      if (clear) clear.hidden = false;
      box.focus(); scroll();
    }

    fetch(form.action, { method: 'POST', body: body, signal: ctl.signal })
      .then(function (r) {
        if (!r.ok) throw new Error('The server answered ' + r.status);
        return readEvents(r, function (name, data) {
          if (name === 'delta') {
            reply += data.text || ''; verb = 'Writing';
            if (!renderTimer) renderTimer = setTimeout(function () { renderTimer = null; render(); }, 80);
          } else if (name === 'status') {
            activity.appendChild(el('p', 'did', data.text || '')); scroll();
          } else if (name === 'artifact') {
            // As in the dock: a visual shows itself in the chat, anything else opens on the stage.
            var w = document.createElement('div'); w.innerHTML = data.html || '';
            var block = w.firstElementChild; if (!block) return;
            var card = block.classList.contains('artifact-card') ? block : block.querySelector('.artifact-card');
            var old = cards.querySelector(':scope > [data-artifact="' + card.dataset.artifact + '"]');
            cards.hidden = false;
            if (old) old.replaceWith(block); else cards.appendChild(block);
            scroll();
            if (block === card && window.openInDock) window.openInDock(card.dataset.artifact, card.dataset.type, card.dataset.title);
          } else if (name === 'proposal') {
            proposals.push(data); verb = 'Proposing an edit';
          } else if (name === 'message') {
            final_ = data;
            var wrap = document.createElement('div'); wrap.innerHTML = data.html || '';
            if (wrap.firstElementChild) { var shown = wrap.firstElementChild; live.replaceWith(shown); showProposals(shown); }
          }
        });
      })
      .catch(function (err) {
        if (err.name === 'AbortError') {
          status.remove();
          if (!reply) activity.appendChild(el('p', 'did', 'Stopped.')); else render();
          showProposals(live);
        } else {
          live.remove();
          var bad = el('article', 'msg msg-error'); bad.appendChild(el('p', '', String(err.message || err)));
          log.appendChild(bad);
        }
      })
      .then(function () {
        // Only a finished exchange is remembered; a stopped or failed one is dropped.
        if (final_ && final_.text) { history.push({ role: 'user', content: text }, { role: 'assistant', content: final_.text }); }
        done();
      });
  }

  // Clear: forget the conversation.
  document.addEventListener('click', function (e) {
    var b = e.target.closest && e.target.closest('.study-form .dock-clear');
    if (!b) return;
    var pane = b.closest('.study');
    restore();
    pane.querySelector('.study-log').innerHTML = '';
    pane._history = [];
    pane.classList.remove('grown');
    b.hidden = true;
    pane.querySelector('textarea').focus();
  });

  document.addEventListener('submit', function (e) {
    var form = e.target.closest && e.target.closest('.study-form');
    if (!form) return;
    e.preventDefault(); send(form);
  });
  // Enter sends, Shift+Enter is a new line.
  document.addEventListener('keydown', function (e) {
    var box = e.target;
    if (!box.matches || !box.matches('.study-form textarea')) return;
    if (e.key === 'Enter' && !e.shiftKey && !e.isComposing) { e.preventDefault(); box.form.requestSubmit(); }
  });
  document.addEventListener('input', function (e) {
    if (e.target.matches && e.target.matches('.study-form textarea')) grow(e.target);
  });
  // Model and effort are remembered, shared with the dock's.
  document.addEventListener('change', function (e) {
    if (!(e.target.matches && e.target.matches('.study-form select[data-pref]'))) return;
    try { localStorage.setItem(e.target.dataset.pref, e.target.value); } catch (x) {}
  });
  // The model is kept by the server (the one last used); every model picker on the page follows a change.
  document.addEventListener('change', function (e) {
    if (!(e.target.matches && e.target.matches('select[name="model"]'))) return;
    document.querySelectorAll('select[name="model"]').forEach(function (s) { s.value = e.target.value; });
  });
  // Panes that are there at the start pick up the remembered choices.
  document.querySelectorAll('.study-form select[data-pref]').forEach(function (s) {
    var v = null;
    try { v = localStorage.getItem(s.dataset.pref); } catch (x) {}
    if (v && Array.prototype.some.call(s.options, function (o) { return o.value === v; })) s.value = v;
  });
})();
