// The Claude dock: the rail of chats at this place, the chat itself, and the stage where
// artifacts open beside it. Open/close, widen, pin to a section, send without leaving
// the page. An ask streams back as server-sent events:
//   chat {id, title, html}   the chat this ask started, when it started one
//   status {text}            what the model is doing (searched, added ideas…)
//   thinking {text}          its reasoning, when "think" is on
//   delta {text}             the reply as it is written (rendered live by md.js)
//   artifact {html}          a card for something it made; opens in the stage
//   message {html, changed}  the stored reply, rendered by the server; replaces the live one
//   done {}
(function () {
  var dock = document.getElementById('dock');
  if (!dock) return;
  var launcher = document.getElementById('dock-open');
  var inline = dock.classList.contains('inline');
  var log = document.getElementById('dock-log');
  var form = document.getElementById('dock-form');
  var input = form.elements.text, here = form.elements.here, chatField = form.elements.chat;
  var mapName = form.elements['map-name'].value;
  var title = document.getElementById('dock-title');
  var list = document.getElementById('chat-list');
  var sendBtn = form.querySelector('.dock-send:not(.dock-stop)'), stopBtn = document.getElementById('dock-stop');
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
  function icon(name) {
    var paths = { check: 'M5 12l5 5L20 7', x: 'M6 6l12 12M18 6L6 18' };
    return '<svg class="ico" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="' + paths[name] + '"></path></svg>';
  }

  // ---- Open, close, widen ----
  function show(on) {
    dock.hidden = !on; launcher.hidden = on;
    keep('sessionStorage', 'dock-open', on ? '1' : '0');
    if (on) { log.scrollTop = log.scrollHeight; if (!inline) input.focus(); }
  }
  launcher.addEventListener('click', function () { show(true); });
  document.getElementById('dock-close').addEventListener('click', function () { if (inline) goHome(); else show(false); });

  document.addEventListener('keydown', function (e) {
    if (e.key !== 'Escape') return;
    if (dock.classList.contains('focus')) { closeStage(); return; }
    if (inline) { if (dock.classList.contains('popover')) goHome(); }
    else if (!dock.hidden) show(false);
  });

  var wide = document.getElementById('dock-wide');
  function setWide(on) {
    dock.classList.toggle('wide', on);
    wide.title = on ? 'Narrow' : 'Widen';
    keep('localStorage', 'dock-wide', on ? '1' : '0');
  }
  wide.addEventListener('click', function () { setWide(!dock.classList.contains('wide')); });
  if (keep('localStorage', 'dock-wide') === '1') setWide(true);

  // ---- The rail: open by default, remembered ----
  function setRail(on) { dock.classList.toggle('rail-open', on); keep('localStorage', 'dock-rail', on ? '1' : '0'); }
  document.getElementById('dock-rail-toggle').addEventListener('click', function () { setRail(!dock.classList.contains('rail-open')); });
  setRail(keep('localStorage', 'dock-rail') !== '0');

  // ---- Chats: one place's list, one open at a time ----
  function chatKey() { return 'dock-chat:' + mapName + ':' + here.value; }
  function itemTitle(li) { return li.querySelector('.chat-title').textContent; }
  function findItem(id) {
    var items = list.querySelectorAll('.chat-item');
    for (var i = 0; i < items.length; i++) if (items[i].dataset.chat === id) return items[i];
    return null;
  }
  function markCurrent(id) {
    list.querySelectorAll('.chat-item').forEach(function (li) { li.classList.toggle('current', li.dataset.chat === id); });
  }
  function noteEmpty() {
    if (list.querySelector('.chat-item')) { var e = list.querySelector('.rail-empty'); if (e) e.remove(); return; }
    if (!list.querySelector('.rail-empty')) {
      var li = document.createElement('li'); li.className = 'rail-empty'; li.textContent = 'No chats here yet.';
      list.appendChild(li);
    }
  }
  // Open a chat (id "" = a new one, not yet started): the log is fetched, the header named.
  function openChat(id, name) {
    chatField.value = id; keep('sessionStorage', chatKey(), id);
    markCurrent(id); title.textContent = id ? name : 'New chat';
    return fetchText('/chat/' + encodeURIComponent(id || 'new') + '?' + qs({ 'map-name': mapName, scope: here.value }))
      .then(function (html) { log.innerHTML = html; log.scrollTop = log.scrollHeight; })
      .catch(showError);
  }
  function newChat() { return openChat('', '').then(function () { input.focus(); }); }
  document.getElementById('dock-new').addEventListener('click', newChat);
  document.getElementById('rail-new').addEventListener('click', newChat);

  // The rail for where the dock is now, then the chat remembered there, else the newest.
  function loadScope() {
    return fetchText('/chats?' + qs({ 'map-name': mapName, scope: here.value }))
      .then(function (html) {
        list.innerHTML = html;
        var remembered = keep('sessionStorage', chatKey());
        var li = (remembered && findItem(remembered)) || (remembered !== '' && list.querySelector('.chat-item'));
        return li ? openChat(li.dataset.chat, itemTitle(li)) : openChat('', '');
      })
      .catch(showError);
  }

  // Rename in place: the title becomes a box; Enter or leaving saves, Escape cancels.
  function startRename(li) {
    if (li.classList.contains('editing')) return;
    li.classList.add('editing');
    var box = document.createElement('input');
    box.className = 'chat-edit'; box.value = itemTitle(li); box.setAttribute('aria-label', 'Chat title');
    var done = false;
    function finish(save) {
      if (done) return; done = true;
      var value = box.value.trim();
      box.remove(); li.classList.remove('editing');
      if (!save || !value || value === itemTitle(li)) return;
      fetchText('/action/rename-chat', { 'map-name': mapName, id: li.dataset.chat, title: value })
        .then(function (saved) {
          if (!saved) return;
          li.querySelector('.chat-title').textContent = saved; li.querySelector('.chat-open').title = saved;
          if (li.dataset.chat === chatField.value) title.textContent = saved;
        })
        .catch(showError);
    }
    box.addEventListener('keydown', function (e) {
      if (e.key === 'Enter') { e.preventDefault(); finish(true); }
      else if (e.key === 'Escape') { finish(false); }
    });
    box.addEventListener('blur', function () { finish(true); });
    li.insertBefore(box, li.firstChild);
    box.focus(); box.select();
  }

  // Delete asks once, in the row itself.
  function startDelete(li) {
    if (li.classList.contains('confirming')) return;
    li.classList.add('confirming');
    var ask = document.createElement('span');
    ask.className = 'chat-confirm';
    ask.innerHTML = '<span>Delete?</span><button type="button" class="yes" title="Delete">' + icon('check') + '</button>' +
      '<button type="button" class="no" title="Keep">' + icon('x') + '</button>';
    ask.querySelector('.no').addEventListener('click', function () { ask.remove(); li.classList.remove('confirming'); });
    ask.querySelector('.yes').addEventListener('click', function () {
      fetchText('/action/delete-chat', { 'map-name': mapName, id: li.dataset.chat })
        .then(function () {
          var wasOpen = li.dataset.chat === chatField.value;
          li.remove(); noteEmpty();
          if (wasOpen) openChat('', '');
        })
        .catch(showError);
    });
    li.appendChild(ask);
    ask.querySelector('.yes').focus();
  }

  list.addEventListener('click', function (e) {
    var li = e.target.closest('.chat-item');
    if (!li) return;
    if (e.target.closest('.chat-rename')) startRename(li);
    else if (e.target.closest('.chat-delete')) startDelete(li);
    else if (e.target.closest('.chat-open')) { openChat(li.dataset.chat, itemTitle(li)); input.focus(); }
  });

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
    var card = t.classList.contains('artifact-card') ? t : t.parentNode.querySelector('.artifact-card');
    if (!card || !card.dataset.artifact) return;
    e.preventDefault(); e.stopPropagation();
    window.openInDock(card.dataset.artifact, card.dataset.type, card.dataset.title, true);
  }, true);
  // The idea study pane opens its artifacts here too.
  window.openInDock = function (id, type, name, full) { show(true); openArtifact(id, type, name, full); };

  // Another idea was opened in place: the chat follows it.
  document.addEventListener('idea-swapped', function () { if (!dock.classList.contains('popover')) loadScope(); });

  // ---- Where the dock is: built in under the open idea, or hung from a section's corner ----
  // Each place has its own chats, so moving the dock reloads the rail.
  var home = dock.parentNode, pill = form.querySelector('.pill-text');
  form.dataset.homeHere = here.value; form.dataset.homeLabel = pill.textContent;
  function moveTo(parent, scope, label, popover) {
    var was = here.value;
    parent.appendChild(dock); dock.classList.toggle('popover', popover);
    here.value = scope; pill.textContent = label;
    document.querySelectorAll('.scope-claude.on').forEach(function (b) { b.classList.remove('on'); });
    if (scope !== was) loadScope();
  }
  function goHome() { moveTo(home, form.dataset.homeHere, form.dataset.homeLabel, false); }
  document.querySelectorAll('.scope-claude').forEach(function (btn) {
    btn.addEventListener('click', function (e) {
      e.preventDefault(); e.stopPropagation(); // buttons inside a <summary> must not fold it
      var anchor = document.getElementById(btn.dataset.anchor);
      // Pressing the button the chat hangs from closes it; any other button points it there.
      if (dock.parentNode === anchor && here.value === btn.dataset.scope) { goHome(); return; }
      moveTo(anchor, btn.dataset.scope, btn.dataset.label, true);
      btn.classList.add('on');
      input.focus();
    });
  });

  // ---- The composer ----
  // Canned asks fill the box and send.
  log.addEventListener('click', function (e) {
    var chip = e.target.closest('.chip');
    if (chip) { input.value = chip.dataset.text; form.requestSubmit(); }
  });
  // Enter sends, Shift+Enter is a new line; the box grows with its text.
  input.addEventListener('keydown', function (e) {
    if (e.key === 'Enter' && !e.shiftKey && !e.isComposing) { e.preventDefault(); form.requestSubmit(); }
  });
  function grow() { input.style.height = 'auto'; input.style.height = Math.min(input.scrollHeight, 176) + 'px'; }
  input.addEventListener('input', grow);
  grow();

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

  // A new chat, started by this ask: it goes to the top of the rail and becomes the open one.
  function chatStarted(data) {
    chatField.value = data.id; keep('sessionStorage', chatKey(), data.id);
    title.textContent = data.title;
    var wrap = document.createElement('ul'); wrap.innerHTML = data.html;
    var li = wrap.firstElementChild;
    if (li) { list.insertBefore(li, list.firstChild); noteEmpty(); }
    markCurrent(data.id);
  }
  // The model's name for it, once the reply is in.
  function chatNamed(data) {
    if (!data.id || !data.title) return;
    var li = findItem(data.id);
    if (li) { li.querySelector('.chat-title').textContent = data.title; li.querySelector('.chat-open').title = data.title; }
    if (data.id === chatField.value) title.textContent = data.title;
  }

  var controller = null;
  stopBtn.addEventListener('click', function () { if (controller) controller.abort(); });

  form.addEventListener('submit', function (e) {
    e.preventDefault();
    var text = input.value.trim();
    if (!text || form.classList.contains('busy')) return;
    input.value = text;
    var body = new URLSearchParams(new FormData(form));

    var empty = log.querySelector('.dock-empty');
    if (empty) empty.remove();
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
    var changed = false;
    // The composer comes back as soon as the reply is in; naming the chat may still be on its way.
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
          else if (name === 'chat') chatStarted(data);
          else if (name === 'title') chatNamed(data);
          else if (name === 'message') { changed = !!data.changed; live.finish(data.html); if (!changed) release(); }
        });
      })
      .catch(function (err) {
        live.finish(null);
        if (err.name !== 'AbortError') showError(err);
      })
      .then(function () {
        if (controller === ctl) controller = null;
        release();
        // A changed map needs the page drawn again; the dock, its chat and stage come back as they were.
        if (changed) { keep('sessionStorage', 'dock-open', '1'); location.reload(); }
      });
  });

  // ---- Start: as the page was left ----
  if (inline || keep('sessionStorage', 'dock-open') === '1') show(true);
  // The server opened the newest chat here; the one left open last wins if it differs.
  var remembered = keep('sessionStorage', chatKey());
  if (remembered !== null && remembered !== undefined && remembered !== chatField.value) {
    var li = remembered && findItem(remembered);
    if (li) openChat(remembered, itemTitle(li)); else if (remembered === '') openChat('', '');
  }
  var staged = keep('sessionStorage', 'dock-stage');
  if (staged) { try { var s = JSON.parse(staged); if (s && s.id) openArtifact(s.id, s.type, s.title); } catch (e) {} }
})();
