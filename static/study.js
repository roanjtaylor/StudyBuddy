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

  // ---- Proposed edits: a diff the learner approves or rejects, like a code review ----
  // Line diff by longest common subsequence; long unchanged runs fold to "…".
  function diffLines(a, b) {
    var x = a ? a.split('\n') : [], y = b ? b.split('\n') : [], n = x.length, m = y.length, i, j;
    var t = [];
    for (i = 0; i <= n; i++) t.push(new Array(m + 1).fill(0));
    for (i = n - 1; i >= 0; i--) for (j = m - 1; j >= 0; j--)
      t[i][j] = x[i] === y[j] ? t[i + 1][j + 1] + 1 : Math.max(t[i + 1][j], t[i][j + 1]);
    var out = []; i = 0; j = 0;
    while (i < n && j < m) {
      if (x[i] === y[j]) { out.push([' ', x[i]]); i++; j++; }
      else if (t[i + 1][j] >= t[i][j + 1]) { out.push(['-', x[i++]]); }
      else { out.push(['+', y[j++]]); }
    }
    while (i < n) out.push(['-', x[i++]]);
    while (j < m) out.push(['+', y[j++]]);
    return out;
  }

  function diffView(before, after) {
    var rows = diffLines(before, after), keep = rows.map(function () { return false; }), CTX = 2;
    rows.forEach(function (r, k) {
      if (r[0] === ' ') return;
      for (var d = -CTX; d <= CTX; d++) if (rows[k + d]) keep[k + d] = true;
    });
    var box = el('div', 'diff'), folded = false;
    rows.forEach(function (r, k) {
      if (!keep[k]) { if (!folded) { box.appendChild(el('div', 'diff-fold', '…')); folded = true; } return; }
      folded = false;
      var line = el('div', 'diff-line ' + (r[0] === '+' ? 'diff-add' : r[0] === '-' ? 'diff-del' : 'diff-ctx'));
      line.appendChild(el('span', 'diff-sign', r[0] === ' ' ? '' : r[0]));
      line.appendChild(el('span', 'diff-text', r[1] === '' ? ' ' : r[1]));
      box.appendChild(line);
    });
    return box;
  }

  function proposalCard(p, form) {
    var card = el('section', 'proposal');
    card.appendChild(el('p', 'proposal-head', 'Proposed edit to ' + (p.title || 'this idea')));
    var chosen = {};
    (p.changes || []).forEach(function (c) {
      var block = el('div', 'proposal-field');
      var label = el('label', 'proposal-label');
      var box = document.createElement('input'); box.type = 'checkbox'; box.checked = true;
      box.onchange = function () { block.classList.toggle('off', !box.checked); };
      label.appendChild(box); label.appendChild(el('span', '', c.label));
      block.appendChild(label); block.appendChild(diffView(c.before, c.after));
      block._take = function () { if (box.checked) chosen[c.field] = c.after; };
      card.appendChild(block);
    });
    var row = el('div', 'proposal-actions'), yes = el('button', 'primary small', 'Approve'),
        no = el('button', 'small', 'Reject'), note = el('span', 'quiet small');
    yes.type = 'button'; no.type = 'button';
    row.appendChild(yes); row.appendChild(no); row.appendChild(note); card.appendChild(row);
    function settle(text, cls) { row.innerHTML = ''; card.classList.add(cls); row.appendChild(el('span', 'quiet small', text)); }
    no.onclick = function () { settle('Rejected. Nothing changed.', 'rejected'); };
    yes.onclick = function () {
      card.querySelectorAll('.proposal-field').forEach(function (b) { b._take(); });
      if (!Object.keys(chosen).length) { settle('Nothing selected. Nothing changed.', 'rejected'); return; }
      yes.disabled = no.disabled = true; note.textContent = 'Applying…';
      var body = new URLSearchParams();
      body.set('map-name', form.elements['map-name'].value); body.set('here', form.elements.here.value);
      body.set('changes', JSON.stringify(chosen));
      fetch('/action/apply-edit', { method: 'POST', body: body })
        .then(function (r) { return r.json(); })
        .then(function (r) {
          if (!r.ok) throw new Error(r.error || 'The edit was not applied.');
          settle('Applied.', 'applied');
          if (window.refreshIdea) window.refreshIdea();
        })
        .catch(function (err) { yes.disabled = no.disabled = false; note.textContent = String(err.message || err); });
    };
    return card;
  }

  function send(form) {
    var pane = form.closest('.study'), log = pane.querySelector('.study-log');
    var box = form.elements.text, text = box.value.trim();
    if (!text || form.classList.contains('busy')) return;
    var history = pane._history || (pane._history = []);

    var body = new URLSearchParams(new FormData(form));
    body.set('text', text);
    body.set('history', JSON.stringify(history));

    var empty = log.querySelector('.study-empty');
    if (empty) empty.remove();
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
    var send_ = form.querySelector('.dock-send:not(.dock-stop)'), stop = form.querySelector('.dock-stop');
    form.classList.add('busy'); send_.hidden = true; stop.hidden = false;
    var ctl = new AbortController();
    stop.onclick = function () { ctl.abort(); };
    var final_ = null, proposals = [];
    // Proposed edits sit under the reply they came with.
    function showProposals(where) { proposals.forEach(function (p) { where.appendChild(proposalCard(p, form)); }); scroll(); }

    function done() {
      clearInterval(timer); if (renderTimer) clearTimeout(renderTimer);
      form.classList.remove('busy'); send_.hidden = false; stop.hidden = true;
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
  // The canned asks fill the box and send.
  document.addEventListener('click', function (e) {
    var chip = e.target.closest && e.target.closest('.study .chip');
    if (!chip) return;
    var form = chip.closest('.study').querySelector('.study-form');
    form.elements.text.value = chip.dataset.text; form.requestSubmit();
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
