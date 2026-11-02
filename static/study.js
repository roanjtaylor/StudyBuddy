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
    live.appendChild(mark); live.appendChild(activity); live.appendChild(md_); live.appendChild(status);
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
    var final_ = null;

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
          } else if (name === 'message') {
            final_ = data;
            var wrap = document.createElement('div'); wrap.innerHTML = data.html || '';
            if (wrap.firstElementChild) live.replaceWith(wrap.firstElementChild);
          }
        });
      })
      .catch(function (err) {
        if (err.name === 'AbortError') {
          status.remove();
          if (!reply) activity.appendChild(el('p', 'did', 'Stopped.')); else render();
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
  // The effort choice is remembered, as the dock's is.
  document.addEventListener('change', function (e) {
    if (!(e.target.matches && e.target.matches('.study-form select'))) return;
    try { localStorage.setItem('dock-effort', e.target.value); } catch (x) {}
    e.target.closest('.toggle').classList.toggle('on', e.target.value !== '');
  });
  // The canned asks fill the box and send.
  document.addEventListener('click', function (e) {
    var chip = e.target.closest && e.target.closest('.study .chip');
    if (!chip) return;
    var form = chip.closest('.study').querySelector('.study-form');
    form.elements.text.value = chip.dataset.text; form.requestSubmit();
  });
  // Panes that are there at the start pick up the remembered effort.
  var saved = null;
  try { saved = localStorage.getItem('dock-effort'); } catch (x) {}
  document.querySelectorAll('.study-form select').forEach(function (s) {
    if (saved) { s.value = saved; s.closest('.toggle').classList.toggle('on', saved !== ''); }
  });
})();
