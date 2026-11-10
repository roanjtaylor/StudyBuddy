// The Claude dock: one chat for the field, and the stage where artifacts open beside it.
// Open/close, send without leaving the page. The chat is not
// stored: its turns live in this tab and go back to the server with every ask.
// An ask streams back as server-sent events:
//   status {text}            what the model is doing (searched, added ideas…)
//   thinking {text}          its reasoning, when "think" is on
//   delta {text}             the reply as it is written (rendered live by md.js)
//   artifact {html}          a card for something it made; opens in the stage
//   message {html, text, changed}  the finished reply, rendered by the server; replaces the live one
//   done {}
// Shared by both chats (breadth here, depth in study.js): the first question opens the pane
// from its resting height to its .grown height with a smooth transition (see .pane in style.css).
window.growPane = function (pane) {
  if (pane.classList.contains('grown')) return;
  var from = pane.offsetHeight;
  pane.classList.add('grown');
  var to = pane.offsetHeight;                 // where the stylesheet puts it
  if (from === to || window.matchMedia('(prefers-reduced-motion: reduce)').matches) return;
  pane.style.flex = 'none'; pane.style.height = from + 'px';
  pane.offsetHeight;                          // settle the starting height, so the change animates
  pane.style.height = to + 'px';
  var done = function () { pane.style.flex = ''; pane.style.height = ''; pane.removeEventListener('transitionend', done); };
  pane.addEventListener('transitionend', done);
  setTimeout(done, 600);
};

(function () {
  var dock = document.getElementById('dock');
  if (!dock) return;
  var launcher = document.getElementById('dock-open');
  var inline = dock.classList.contains('inline');
  var log = document.getElementById('dock-log');
  var form = document.getElementById('dock-form');
  var input = form.elements.text, here = form.elements.here;
  var mapName = form.elements['map-name'].value;
  var sendBtn = form.querySelector('.dock-send:not(.dock-stop)'), stopBtn = form.querySelector('.dock-stop');
  var stage = document.getElementById('dock-stage'), frame = document.getElementById('stage-frame');
  var stageTitle = document.getElementById('stage-title');

  function keep(store, key, value) {
    try { if (value === undefined) return window[store].getItem(key); window[store].setItem(key, value); } catch (e) {}
  }
  function qs(params) { return new URLSearchParams(params).toString(); }
  function fetchText(url, body) {
    return fetch(url, body ? { method: 'POST', body: new URLSearchParams(body) } : undefined)
      .then(function (r) { if (!r.ok) throw new Error('The server answered ' + r.status); return r.text(); });
  }
  function showError(err) {
    var bad = document.createElement('article');
    bad.className = 'msg msg-error';
    var m = document.createElement('p');
    m.textContent = String(err.message || err);
    bad.appendChild(m);
    log.appendChild(bad);
    log.scrollTop = log.scrollHeight;
  }
  // ---- Open, close, widen ----
  function show(on) {
    dock.hidden = !on; launcher.hidden = on;
    keep('sessionStorage', 'dock-open', on ? '1' : '0');
    if (on) { log.scrollTop = log.scrollHeight; if (!inline) input.focus(); }
  }
  launcher.addEventListener('click', function () { show(true); });

  document.addEventListener('keydown', function (e) {
    if (e.key !== 'Escape') return;
    if (dock.classList.contains('focus')) { closeStage(); return; }
    if (!inline && !dock.hidden) show(false);
  });

  // ---- The chat: one, for as long as this page is open ----
  // Nothing is stored on the server, and a reload starts afresh, as in the study pane.
  // The one exception: a map change redraws the page, so the chat is handed across that
  // reload (once) through the tab's session storage.
  var turns = [], chatKey = 'dock-chat:' + mapName;

  // ---- The stage: one artifact open beside the chat ----
  var sandboxed = { html: 1, svg: 1, mermaid: 1 };
  var artifactField = form.elements.artifact, stageFocus = document.getElementById('stage-focus');
  var openId = '', openType = '';
  function openArtifact(id, type, name, full) {
    stageTitle.textContent = name || id;
    // The model's own documents run cut off from the app; the app's viewers run as the app.
    if (sandboxed[type]) frame.setAttribute('sandbox', 'allow-scripts allow-forms allow-popups allow-modals allow-downloads');
    else frame.removeAttribute('sandbox');
    stage.hidden = false;
    dock.classList.add('staged');
    if (full) setFocus(true);   // before the frame loads: moving the dock reloads it
    // The same artifact again (a new version) must load afresh.
    frame.src = '/artifact/' + id + '/view' + (id === openId ? '?t=' + Date.now() : '');
    openId = id; openType = type;
    if (artifactField) artifactField.value = id;
    keep('sessionStorage', 'dock-stage', JSON.stringify({ id: id, type: type, title: name }));
  }
  function closeStage() {
    // All at once: blank the frame first (moving the dock would reload it), then drop the
    // scrim and the dock's full-screen state in the same tick.
    frame.src = 'about:blank';
    stage.hidden = true; dock.classList.remove('staged');
    setFocus(false);
    scrim.hidden = true; document.body.classList.remove('dock-focus');
    openId = ''; if (artifactField) artifactField.value = '';
    keep('sessionStorage', 'dock-stage', '');
  }
  document.getElementById('stage-close').addEventListener('click', closeStage);

  // ---- Full screen: the artifact large on the left, the chat on the right, the page greyed behind ----
  // The dock may sit in a hidden part of the page (the idea's own section), so full screen
  // lifts it to <body> and puts it back afterwards.
  var scrim = document.createElement('div'); scrim.className = 'dock-scrim'; scrim.hidden = true;
  document.body.appendChild(scrim);
  var restore = null;
  function setFocus(on) {
    var now = dock.classList.contains('focus');
    if (on === now) return;
    if (on) {
      restore = { parent: dock.parentNode, next: dock.nextSibling };
      document.body.appendChild(dock);
      dock.hidden = false; launcher.hidden = true;
    } else if (restore) {
      restore.parent.insertBefore(dock, restore.next && restore.next.parentNode === restore.parent ? restore.next : null);
      restore = null;
    }
    dock.classList.toggle('focus', on);
    scrim.hidden = !on;
    document.body.classList.toggle('dock-focus', on);
    stageFocus.title = on ? 'Exit full screen' : 'Full screen';
    stageFocus.setAttribute('aria-label', stageFocus.title);
    if (on) { log.scrollTop = log.scrollHeight; input.focus(); }
  }
  stageFocus.addEventListener('click', function () { setFocus(true); });
  // X, Esc or a click on the greyed page closes the artifact and leaves you where you were.
  document.getElementById('stage-x').addEventListener('click', closeStage);
  scrim.addEventListener('click', closeStage);

  // A click on an artifact's card, or on the expand button over its preview, opens it over
  // the page, wherever the card is. It never leaves the page for the artifact's own address.
  document.addEventListener('click', function (e) {
    var t = e.target.closest && (e.target.closest('.artifact-expand') || e.target.closest('.artifact-card'));
    if (!t) return;
    var card = t.classList.contains('artifact-card') ? t : t.closest('.artifact-inline').querySelector('.artifact-card');
    if (!card || !card.dataset.artifact) return;
    e.preventDefault(); e.stopPropagation();
    window.openInDock(card.dataset.artifact, card.dataset.type, card.dataset.title, true);
  }, true);
  // The idea study pane opens its artifacts here too.
  window.openInDock = function (id, type, name, full) { show(true); openArtifact(id, type, name, full); };

  // ---- The composer ----
  // Enter sends, Shift+Enter is a new line; the box grows with its text.
  input.addEventListener('keydown', function (e) {
    if (e.key === 'Enter' && !e.shiftKey && !e.isComposing) { e.preventDefault(); form.requestSubmit(); }
  });
  // While the dock is hidden the box measures 0: leave its height to the stylesheet then,
  // or it would be pinned at 0px and could not be clicked or typed in once shown.
  function grow() {
    input.style.height = 'auto';
    if (input.scrollHeight) input.style.height = Math.min(input.scrollHeight, 176) + 'px';
  }
  input.addEventListener('input', grow);

  // Model and effort are remembered (the select's own default stands until chosen).
  form.querySelectorAll('select[data-pref]').forEach(function (s) {
    var k = s.dataset.pref, v = keep('localStorage', k);
    if (v && Array.prototype.some.call(s.options, function (o) { return o.value === v; })) s.value = v;
    s.addEventListener('change', function () { keep('localStorage', k, s.value); });
  });

  // ---- The live reply: built up from events, replaced by the stored one at the end ----
  var frames = ['·', '✢', '✳', '✶', '✻', '✽', '✻', '✶', '✳', '✢'];
  function liveMessage() {
    var el = document.createElement('article');
    el.className = 'msg msg-buddy live';
    var mark = document.createElement('span'); mark.className = 'msg-mark';
    mark.innerHTML = '<svg class="mark" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round"><path d="M12 3v18M3 12h18M5.6 5.6l12.8 12.8M18.4 5.6 5.6 18.4"></path></svg>';
    var activity = document.createElement('div'); activity.className = 'activity';
    var status = document.createElement('p'); status.className = 'dock-status'; status.setAttribute('role', 'status');
    var think = document.createElement('details'); think.className = 'thinking'; think.hidden = true;
    var sum = document.createElement('summary'); sum.textContent = 'Thinking'; think.appendChild(sum);
    var thinkBody = document.createElement('div'); thinkBody.className = 'thinking-text'; think.appendChild(thinkBody);
    var body = document.createElement('div'); body.className = 'md';
    var cards = document.createElement('div'); cards.className = 'msg-artifacts'; cards.hidden = true;
    el.appendChild(mark); el.appendChild(think); el.appendChild(activity); el.appendChild(body); el.appendChild(cards); el.appendChild(status);

    var t0 = Date.now(), i = 0, text = '', thinking = '', renderTimer = null, verb = 'Thinking';
    var thinkFrom = 0, thinkTo = 0;
    function tick() {
      status.innerHTML = '<span class="spin">' + frames[i++ % frames.length] + '</span> ' + md.escape(verb) + '… ' +
        Math.round((Date.now() - t0) / 1000) + 's';
    }
    tick();
    var timer = setInterval(tick, 130);
    function render() { body.innerHTML = md.render(text); log.scrollTop = log.scrollHeight; }
    function thoughtFor() {
      if (!thinkFrom) return;
      sum.textContent = 'Thought for ' + Math.max(1, Math.round(((thinkTo || Date.now()) - thinkFrom) / 1000)) + 's';
    }
    return {
      el: el,
      delta: function (s) {
        text += s; verb = 'Writing';
        if (thinkFrom && !thinkTo) { thinkTo = Date.now(); thoughtFor(); }
        if (!renderTimer) renderTimer = setTimeout(function () { renderTimer = null; render(); }, 80);
      },
      thinking: function (s) {
        if (!thinkFrom) thinkFrom = Date.now();
        thinking += s; think.hidden = false; thinkBody.textContent = thinking; verb = 'Thinking';
      },
      status: function (s) {
        var p = document.createElement('p'); p.className = 'did'; p.textContent = s; activity.appendChild(p);
        log.scrollTop = log.scrollHeight;
      },
      artifact: function (html) {
        cards.hidden = false;
        var wrap = document.createElement('div'); wrap.innerHTML = html;
        // A visual artifact comes as a figure (its preview and its card); the rest as a card.
        var block = wrap.firstElementChild;
        var card = block.classList.contains('artifact-card') ? block : block.querySelector('.artifact-card');
        // A new version of an open artifact replaces its block; anything new is opened.
        var old = cards.querySelector(':scope > [data-artifact="' + card.dataset.artifact + '"]');
        if (old) old.replaceWith(block); else cards.appendChild(block);
        log.scrollTop = log.scrollHeight;
        // A visual shows itself in the chat; anything else opens on the stage. A click on a card opens either.
        // In full screen, whatever it makes or changes appears on the stage at once.
        if (block === card || dock.classList.contains('focus') || card.dataset.artifact === openId)
          openArtifact(card.dataset.artifact, card.dataset.type, card.dataset.title);
      },
      finish: function (html) {
        clearInterval(timer); if (renderTimer) clearTimeout(renderTimer);
        if (!thinkTo) thinkTo = Date.now();
        thoughtFor();
        if (html) {
          var wrap = document.createElement('div'); wrap.innerHTML = html;
          var done = wrap.firstElementChild;
          if (!think.hidden) { var m = done.querySelector('.msg-mark'); done.insertBefore(think, m ? m.nextSibling : done.firstChild); }
          el.replaceWith(done);
        } else {
          status.remove();
          if (!text) { var p = document.createElement('p'); p.className = 'did'; p.textContent = 'Stopped.'; el.appendChild(p); }
          else render();
        }
      }
    };
  }

  // Read an SSE body from fetch, calling on(name, data) per event. Lines may end in
  // LF or CRLF (the server on Windows sends CRLF), so both are event boundaries.
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

  var controller = null;
  stopBtn.addEventListener('click', function () { if (controller) controller.abort(); });

  form.addEventListener('submit', function (e) {
    e.preventDefault();
    var text = input.value.trim();
    if (!text || form.classList.contains('busy')) return;
    input.value = text;
    // Inline (breadth) chat: once asked something, stretch to the timeline's height.
    if (inline) window.growPane(dock);
    var body = new URLSearchParams(new FormData(form));
    body.set('history', JSON.stringify(turns));
    var reply = null;

    var mine = document.createElement('article');
    mine.className = 'msg msg-you';
    var p = document.createElement('p');
    p.textContent = text;
    mine.appendChild(p);
    log.appendChild(mine);
    var live = liveMessage();
    log.appendChild(live.el);
    log.scrollTop = log.scrollHeight;
    input.value = ''; grow();
    form.classList.add('busy'); sendBtn.hidden = true; stopBtn.hidden = false;
    var ctl = new AbortController();
    controller = ctl;
    var changed = false, proposals = [];
    function release() {
      if (!form.classList.contains('busy')) return;
      form.classList.remove('busy'); sendBtn.hidden = false; stopBtn.hidden = true;
      log.scrollTop = log.scrollHeight;
      input.focus();
    }

    fetch(form.action, { method: 'POST', body: body, signal: ctl.signal })
      .then(function (r) {
        if (!r.ok) throw new Error('The server answered ' + r.status);
        return readEvents(r, function (name, data) {
          if (name === 'delta') live.delta(data.text || '');
          else if (name === 'thinking') live.thinking(data.text || '');
          else if (name === 'status') live.status(data.text || '');
          else if (name === 'artifact') live.artifact(data.html || '');
          else if (name === 'proposal') proposals.push(data);
          else if (name === 'message') {
            changed = !!data.changed; reply = data.text; live.finish(data.html); if (!changed) release();
            // A proposed change to the map is reviewed on the timeline, under the reply it came with.
            if (proposals.length) review(proposals[proposals.length - 1], log.lastElementChild);
          }
        });
      })
      .catch(function (err) {
        live.finish(null);
        if (err.name !== 'AbortError') showError(err);
      })
      .then(function () {
        if (controller === ctl) controller = null;
        release();
        // Only a finished exchange is remembered; a stopped or failed one is dropped.
        if (reply) turns.push({ role: 'user', content: text }, { role: 'assistant', content: reply });
        // A changed map needs the page drawn again; the chat, where it hung and the stage come back as they were.
        if (changed) reloadKeepingChat();
      });
  });

  // ---- Proposed changes to the map: reviewed on the timeline ----
  // The model never edits the map. It proposes; the changes replace the chat on the
  // right with removals in red and additions in green (the same marks as the depth chat's
  // review), and nothing is applied until the learner approves. Either answer leaves the chat where it was.
  function reloadKeepingChat() {
    keep('sessionStorage', chatKey, JSON.stringify({ html: log.innerHTML, turns: turns }));
    location.reload();
  }
  function h(tag, cls, text) {
    var e = document.createElement(tag);
    if (cls) e.className = cls;
    if (text) e.textContent = text;
    return e;
  }
  var shownReview = null;
  function dropReview() {
    if (!shownReview) return;
    shownReview.undo.forEach(function (f) { f(); });
    shownReview = null;
  }
  function groupBlock(id) {
    var found = null;
    document.querySelectorAll('.tl-group').forEach(function (d) {
      var t = d.querySelector('.bar-title');
      if (t && t.textContent === id) found = d;
    });
    return found;
  }
  function ideaLink(id) {
    return document.querySelector('.tl-group a.tl-idea[href$="/' + id + '"]');
  }
  function review(p, where) {
    var changes = p.changes || [];
    if (!changes.length || !where) return;
    dropReview();
    var undo = [], counts = { add: 0, update: 0, remove: 0, group: 0 };
    function mark(id, cls) {
      var dot = ideaLink(id);
      if (!dot) return;
      dot.classList.add(cls);
      undo.push(function () { dot.classList.remove(cls); });
    }

    function markGroup(id, cls) {
      var d = groupBlock(id);
      if (!d) return;
      d.classList.add(cls);
      undo.push(function () { d.classList.remove(cls); });
    }
    changes.forEach(function (c) {
      counts[c.kind] = (counts[c.kind] || 0) + 1;
      if (c.kind === 'dropgroup') markGroup(c.id, 'tl-g-del');
      else if (c.kind === 'editgroup') markGroup(c.id, 'tl-g-upd');
      else if (c.kind === 'remove') mark(c.id, 'tl-marked-del');
      else if (c.kind === 'update') mark(c.id, 'tl-marked-upd');
    });

    // The timeline as it is, every group open, so each idea the change touches can be seen.
    document.querySelectorAll('.tl-group').forEach(function (d) {
      var was = d.open; d.open = true;
      undo.push(function () { d.open = was; });
    });

    // On the right, in place of the chat: the timeline as it would be, drawn by the server.
    var panel = h('section', 'review map-review'), pic = h('div', 'map-preview');
    panel.setAttribute('aria-label', 'Proposed changes to the map');
    pic.appendChild(h('p', 'quiet small', 'Drawing the new timeline…'));

    var note = h('p', 'review-note quiet small'),
        bar = h('div', 'review-bar'), yes = h('button', 'approve', '✓ Approve'), no = h('button', 'reject', '✕ Reject');
    yes.type = 'button'; no.type = 'button';
    var side = dock.parentNode;
    panel.appendChild(pic);
    bar.appendChild(yes); bar.appendChild(no); panel.appendChild(note); panel.appendChild(bar);
    var q = new URLSearchParams();
    q.set('map-name', mapName); q.set('changes', JSON.stringify(changes));
    fetch('/action/preview-map', { method: 'POST', body: q })
      .then(function (r) { return r.json(); })
      .then(function (r) {
        pic.innerHTML = r.html || '';
        // Groups that move away from where they were: red on the timeline as it is.
        (r.moved || []).forEach(function (id) { markGroup(id, 'tl-g-del'); });
      })
      .catch(function () { pic.innerHTML = ''; pic.appendChild(h('p', 'quiet small', 'The new timeline could not be drawn.')); });
    side.appendChild(panel); side.classList.add('reviewing');
    undo.push(function () { panel.remove(); side.classList.remove('reviewing'); });
    shownReview = { undo: undo };

    function settle(text) {
      dropReview();
      input.focus();
      where.appendChild(h('p', 'quiet small proposal-note', text));
      log.scrollTop = log.scrollHeight;
    }
    no.onclick = function () { settle('Changes rejected. Nothing changed.'); };
    yes.onclick = function () {
      yes.disabled = no.disabled = true; note.textContent = 'Applying…';
      var body = new URLSearchParams();
      body.set('map-name', mapName); body.set('changes', JSON.stringify(changes));
      fetch('/action/apply-map', { method: 'POST', body: body })
        .then(function (r) { return r.json(); })
        .then(function (r) {
          if (!r.ok) throw new Error(r.error || 'The changes were not applied.');
          // The timeline is drawn on the server: redraw the page, the chat kept.
          settle('Changes approved and applied.');
          reloadKeepingChat();
        })
        .catch(function (err) { yes.disabled = no.disabled = false; note.textContent = String(err.message || err); });
    };
  }

  // ---- Start: as the page was left ----
  if (inline || keep('sessionStorage', 'dock-open') === '1') show(true);
  try {
    var saved = JSON.parse(keep('sessionStorage', chatKey) || 'null');
    keep('sessionStorage', chatKey, '');
    if (saved) {
      log.innerHTML = saved.html || ''; turns = saved.turns || [];
      log.scrollTop = log.scrollHeight;
    }
  } catch (e) {}
  var staged = keep('sessionStorage', 'dock-stage');
  if (staged) { try { var s = JSON.parse(staged); if (s && s.id) openArtifact(s.id, s.type, s.title); } catch (e) {} }
})();
