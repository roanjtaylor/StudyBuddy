// The Claude dock: open/close, widen, send without leaving the page, and the stage
// where artifacts open beside the chat. An ask streams back as server-sent events:
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
  var log = document.getElementById('dock-log');
  var form = document.getElementById('dock-form');
  var input = form.elements.text, here = form.elements.here;
  var sendBtn = form.querySelector('.dock-send:not(.dock-stop)'), stopBtn = document.getElementById('dock-stop');
  var stage = document.getElementById('dock-stage'), frame = document.getElementById('stage-frame');
  var stageTitle = document.getElementById('stage-title'), stageOpen = document.getElementById('stage-open');

  function keep(store, key, value) {
    try { if (value === undefined) return window[store].getItem(key); window[store].setItem(key, value); } catch (e) {}
  }

  function show(on) {
    dock.hidden = !on; launcher.hidden = on;
    keep('sessionStorage', 'dock-open', on ? '1' : '0');
    if (on) { log.scrollTop = log.scrollHeight; input.focus(); }
  }
  launcher.addEventListener('click', function () { show(true); });
  document.getElementById('dock-close').addEventListener('click', function () { show(false); });
  document.addEventListener('keydown', function (e) { if (e.key === 'Escape' && !dock.hidden) show(false); });

  var wide = document.getElementById('dock-wide');
  function setWide(on) {
    dock.classList.toggle('wide', on);
    wide.textContent = on ? '⇤' : '⇥'; wide.title = on ? 'Narrow' : 'Widen';
    keep('localStorage', 'dock-wide', on ? '1' : '0');
  }
  wide.addEventListener('click', function () { setWide(!dock.classList.contains('wide')); });
  if (keep('localStorage', 'dock-wide') === '1') setWide(true);

  // ---- The stage: one artifact open beside the chat ----
  var sandboxed = { html: 1, svg: 1, mermaid: 1 };
  function openArtifact(id, type, title) {
    stageTitle.textContent = title || id;
    stageOpen.href = '/artifact/' + id;
    // The model's own documents run cut off from the app; the app's viewers run as the app.
    if (sandboxed[type]) frame.setAttribute('sandbox', 'allow-scripts allow-forms allow-popups allow-modals allow-downloads');
    else frame.removeAttribute('sandbox');
    frame.src = '/artifact/' + id + '/view';
    stage.hidden = false;
    dock.classList.add('staged');
    keep('sessionStorage', 'dock-stage', JSON.stringify({ id: id, type: type, title: title }));
  }
  function closeStage() {
    stage.hidden = true; dock.classList.remove('staged');
    frame.src = 'about:blank';
    keep('sessionStorage', 'dock-stage', '');
  }
  document.getElementById('stage-close').addEventListener('click', closeStage);
  document.addEventListener('click', function (e) {
    var card = e.target.closest('.artifact-card');
    if (!card || !dock.contains(card)) return;
    e.preventDefault();
    show(true);
    openArtifact(card.dataset.artifact, card.dataset.type, card.dataset.title);
  });

  // × on the "Looking at" chip steps out to the whole field.
  var drop = document.getElementById('dock-drop');
  if (drop) drop.addEventListener('click', function () {
    here.value = '';
    form.querySelector('.pill-text').textContent = form.dataset.field;
    drop.remove();
  });

  // Canned asks fill the box and send.
  log.addEventListener('click', function (e) {
    var chip = e.target.closest('.chip');
    if (chip) { input.value = chip.dataset.text; form.requestSubmit(); }
  });

  // Enter sends, Shift+Enter is a new line.
  input.addEventListener('keydown', function (e) {
    if (e.key === 'Enter' && !e.shiftKey && !e.isComposing) { e.preventDefault(); form.requestSubmit(); }
  });

  var effort = document.getElementById('dock-effort');
  if (effort) {
    effort.value = keep('localStorage', 'dock-effort') || '';
    effort.addEventListener('change', function () { keep('localStorage', 'dock-effort', effort.value); });
  }

  // ---- The live reply: built up from events, replaced by the stored one at the end ----
  var frames = ['·', '✢', '✳', '✶', '✻', '✽', '✻', '✶', '✳', '✢'];
  function liveMessage() {
    var el = document.createElement('article');
    el.className = 'msg msg-buddy live';
    var activity = document.createElement('div'); activity.className = 'activity';
    var status = document.createElement('p'); status.className = 'dock-status'; status.setAttribute('role', 'status');
    var think = document.createElement('details'); think.className = 'thinking'; think.hidden = true;
    var sum = document.createElement('summary'); sum.textContent = 'Thinking'; think.appendChild(sum);
    var thinkBody = document.createElement('div'); thinkBody.className = 'thinking-text'; think.appendChild(thinkBody);
    var body = document.createElement('div'); body.className = 'md';
    var cards = document.createElement('div'); cards.className = 'msg-artifacts'; cards.hidden = true;
    el.appendChild(think); el.appendChild(activity); el.appendChild(body); el.appendChild(cards); el.appendChild(status);

    var t0 = Date.now(), i = 0, text = '', thinking = '', renderTimer = null, verb = 'Thinking';
    function tick() {
      status.innerHTML = '<span class="spin">' + frames[i++ % frames.length] + '</span> ' + md.escape(verb) + '… (' +
        Math.round((Date.now() - t0) / 1000) + 's)';
    }
    tick();
    var timer = setInterval(tick, 130);
    function render() { body.innerHTML = md.render(text); log.scrollTop = log.scrollHeight; }
    return {
      el: el,
      delta: function (s) {
        text += s; verb = 'Writing';
        if (!renderTimer) renderTimer = setTimeout(function () { renderTimer = null; render(); }, 80);
      },
      thinking: function (s) {
        thinking += s; think.hidden = false; thinkBody.textContent = thinking; verb = 'Thinking';
      },
      status: function (s) {
        var p = document.createElement('p'); p.className = 'did'; p.textContent = s; activity.appendChild(p);
        log.scrollTop = log.scrollHeight;
      },
      artifact: function (html) {
        cards.hidden = false;
        var wrap = document.createElement('div'); wrap.innerHTML = html;
        var card = wrap.firstElementChild;
        // A new version of an open artifact replaces its card; anything new is opened.
        var old = cards.querySelector('[data-artifact="' + card.dataset.artifact + '"]');
        if (old) old.replaceWith(card); else cards.appendChild(card);
        openArtifact(card.dataset.artifact, card.dataset.type, card.dataset.title);
      },
      finish: function (html) {
        clearInterval(timer); if (renderTimer) clearTimeout(renderTimer);
        if (html) {
          var wrap = document.createElement('div'); wrap.innerHTML = html;
          var done = wrap.firstElementChild;
          if (!think.hidden) done.insertBefore(think, done.firstChild);
          el.replaceWith(done);
        } else {
          status.remove();
          if (!text) { var p = document.createElement('p'); p.className = 'did'; p.textContent = 'Stopped.'; el.appendChild(p); }
          else render();
        }
      }
    };
  }

  // Read an SSE body from fetch, calling on(name, data) per event.
  function readEvents(response, on) {
    var reader = response.body.getReader(), decoder = new TextDecoder(), buf = '';
    function handle(chunk) {
      var name = 'message', data = [];
      chunk.split('\n').forEach(function (line) {
        if (line.indexOf('event:') === 0) name = line.slice(6).trim();
        else if (line.indexOf('data:') === 0) data.push(line.slice(5).trim());
      });
      if (data.length) { try { on(name, JSON.parse(data.join('\n'))); } catch (e) { on(name, {}); } }
    }
    return reader.read().then(function step(r) {
      if (r.done) { if (buf.trim()) handle(buf); return; }
      buf += decoder.decode(r.value, { stream: true });
      var parts = buf.split('\n\n');
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
    var body = new URLSearchParams(new FormData(form));

    var empty = log.querySelector('.dock-empty');
    if (empty) { empty.remove(); log.querySelector('.dock-chips').remove(); }
    var mine = document.createElement('article');
    mine.className = 'msg msg-you';
    var p = document.createElement('p');
    p.textContent = text;
    mine.appendChild(p);
    log.appendChild(mine);
    var live = liveMessage();
    log.appendChild(live.el);
    log.scrollTop = log.scrollHeight;
    input.value = '';
    form.classList.add('busy'); sendBtn.hidden = true; stopBtn.hidden = false;
    controller = new AbortController();
    var changed = false;

    fetch(form.action, { method: 'POST', body: body, signal: controller.signal })
      .then(function (r) {
        if (!r.ok) throw new Error('The server answered ' + r.status);
        return readEvents(r, function (name, data) {
          if (name === 'delta') live.delta(data.text || '');
          else if (name === 'thinking') live.thinking(data.text || '');
          else if (name === 'status') live.status(data.text || '');
          else if (name === 'artifact') live.artifact(data.html || '');
          else if (name === 'message') { changed = !!data.changed; live.finish(data.html); }
        });
      })
      .catch(function (err) {
        if (err.name === 'AbortError') { live.finish(null); return; }
        live.finish(null);
        var bad = document.createElement('article');
        bad.className = 'msg msg-error';
        var m = document.createElement('p');
        m.textContent = String(err.message || err);
        bad.appendChild(m);
        log.appendChild(bad);
      })
      .then(function () {
        controller = null;
        form.classList.remove('busy'); sendBtn.hidden = false; stopBtn.hidden = true;
        log.scrollTop = log.scrollHeight;
        input.focus();
        // A changed map needs the page drawn again; the dock and stage come back as they were.
        if (changed) { keep('sessionStorage', 'dock-open', '1'); location.reload(); }
      });
  });

  if (keep('sessionStorage', 'dock-open') === '1') show(true);
  var staged = keep('sessionStorage', 'dock-stage');
  if (staged) { try { var s = JSON.parse(staged); if (s && s.id) openArtifact(s.id, s.type, s.title); } catch (e) {} }
})();
