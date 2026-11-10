// Videos pinned to an idea. Under the idea's text a "Find videos" button opens a YouTube
// browser right in the left column: search (or paste a link), watch a result embedded in
// place, pin it to the idea. Pinned videos stay under the text and play in the same player.
// Events are delegated from the document, so an idea swapped in by map.js just works.
(function () {
  function el(tag, cls, text) {
    var e = document.createElement(tag);
    if (cls) e.className = cls;
    if (text) e.textContent = text;
    return e;
  }
  function post(url, data) {
    var body = new URLSearchParams();
    Object.keys(data).forEach(function (k) { body.set(k, data[k]); });
    return fetch(url, { method: 'POST', body: body }).then(function (r) { return r.json(); });
  }
  function pinned(sec, id) { return sec.querySelector('.vid-list .vid[data-video="' + id + '"]'); }

  // Put a video in the section's player (an embed, so it plays here and nowhere else).
  function play(sec, id, title) {
    var box = sec.querySelector('.vid-player');
    box.innerHTML = '';
    var frame = el('iframe');
    frame.src = 'https://www.youtube-nocookie.com/embed/' + encodeURIComponent(id) + '?autoplay=1&rel=0';
    frame.title = title || 'YouTube video';
    frame.allow = 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; fullscreen';
    frame.allowFullscreen = true;
    frame.referrerPolicy = 'strict-origin-when-cross-origin';
    var bar = el('div', 'vid-player-bar'), name = el('span', 'vid-player-title', title || ''),
        close = el('button', 'vid-close', '× Close');
    close.type = 'button';
    bar.appendChild(name); bar.appendChild(close);
    box.appendChild(frame); box.appendChild(bar);
    box.hidden = false;
    box.scrollIntoView({ block: 'nearest', behavior: 'smooth' });
  }

  function syncPinned(sec) {
    var list = sec.querySelector('.vid-list'), any = list.children.length > 0;
    list.hidden = !any;
    sec.querySelector('.videos-h').hidden = !any;
  }

  var PIN = '<svg viewBox="0 0 24 24" width="16" height="16" fill="currentColor" aria-hidden="true"><path d="M16 3a1 1 0 0 1 .7 1.7L15.4 6l1.8 5.4 1.5 1.5a1 1 0 0 1-.7 1.7H13v5.3l-1 2-1-2v-5.3H6a1 1 0 0 1-.7-1.7l1.5-1.5L8.6 6 7.3 4.7A1 1 0 0 1 8 3z"/></svg>';
  function setPin(btn, state) {
    btn.disabled = state !== 'idle';
    btn.classList.toggle('pinned', state === 'pinned');
    btn.innerHTML = PIN + '<span>' + (state === 'pinned' ? 'Pinned' : state === 'busy' ? 'Pinning…' : 'Pin') + '</span>';
    btn.title = state === 'pinned' ? 'Pinned to this idea' : 'Pin to this idea';
  }

  // A result laid out as YouTube does: a large thumbnail, then channel avatar, title, and
  // channel / views underneath, with the pin inside the card.
  function result(sec, r) {
    var li = el('li', 'vid vid-result');
    function playBtn(cls) {
      var b = el('button', 'vid-play ' + cls); b.type = 'button';
      b.dataset.video = r.video; b.dataset.title = r.title; return b;
    }
    var thumb = playBtn('vr-thumb'), img = el('img'); img.alt = ''; img.loading = 'lazy';
    img.src = 'https://i.ytimg.com/vi/' + r.video + '/hqdefault.jpg';
    thumb.appendChild(img);
    if (r.length) thumb.appendChild(el('span', 'vr-len', r.length));

    var info = el('div', 'vr-info');
    var av = el('span', 'vr-avatar');
    if (r.avatar) { var a = el('img'); a.alt = ''; a.loading = 'lazy'; a.referrerPolicy = 'no-referrer'; a.src = r.avatar; av.appendChild(a); }
    else av.textContent = (r.channel || '?').charAt(0).toUpperCase();
    var text = el('div', 'vr-text');
    var title = playBtn('vr-title'); title.textContent = r.title;
    text.appendChild(title);
    if (r.channel) text.appendChild(el('span', 'vr-channel', r.channel));
    var facts = [r.views && (/view/i.test(r.views) ? r.views : r.views + ' views'), r.published].filter(Boolean).join(' · ');
    if (facts) text.appendChild(el('span', 'vr-facts', facts));
    var pin = el('button', 'vid-pin'); pin.type = 'button';
    pin.dataset.video = r.video; pin.dataset.title = r.title; pin.dataset.channel = r.channel || '';
    setPin(pin, pinned(sec, r.video) ? 'pinned' : 'idle');
    info.appendChild(av); info.appendChild(text); info.appendChild(pin);
    li.appendChild(thumb); li.appendChild(info);
    return li;
  }

  function runSearch(sec, q) {
    var status = sec.querySelector('.vid-status'), list = sec.querySelector('.vid-results');
    status.textContent = 'Searching…'; list.innerHTML = '';
    return post('/action/video-search', { q: q })
      .then(function (r) {
        if (!r.ok) { status.textContent = r.error || 'Search failed.'; return; }
        status.textContent = r.results.length ? '' : 'No videos found.';
        r.results.forEach(function (v) { list.appendChild(result(sec, v)); });
      })
      .catch(function () { status.textContent = 'Search failed.'; });
  }

  document.addEventListener('click', function (e) {
    var t = e.target.closest && e.target.closest('.videos button');
    if (!t) return;
    var sec = t.closest('.videos');

    if (t.classList.contains('vid-open')) {
      var browse = sec.querySelector('.vid-browse');
      browse.hidden = !browse.hidden;
      t.setAttribute('aria-expanded', String(!browse.hidden));
      if (!browse.hidden) {
        var input = browse.querySelector('input');
        // The first time, search for the idea itself; the box stays editable for anything else.
        if (!browse.dataset.searched) {
          browse.dataset.searched = '1';
          input.value = sec.dataset.title || '';
          if (input.value) runSearch(sec, input.value);
        }
        browse.scrollIntoView({ block: 'nearest', behavior: 'smooth' });
        input.focus(); input.select();
      }
    } else if (t.classList.contains('vid-close')) {
      var box = sec.querySelector('.vid-player');
      box.hidden = true; box.innerHTML = '';
    } else if (t.classList.contains('vid-play')) {
      play(sec, t.dataset.video, t.dataset.title);
    } else if (t.classList.contains('vid-pin')) {
      setPin(t, 'busy');
      post('/action/pin-video', { 'map-name': sec.dataset.map, 'node-id': sec.dataset.node,
                                  video: t.dataset.video, title: t.dataset.title, channel: t.dataset.channel })
        .then(function (r) {
          if (!r.ok) throw new Error(r.error);
          var w = document.createElement('ul'); w.innerHTML = r.html;
          if (!pinned(sec, t.dataset.video)) sec.querySelector('.vid-list').appendChild(w.firstElementChild);
          syncPinned(sec);
          setPin(t, 'pinned');
        })
        .catch(function () { setPin(t, 'idle'); });
    } else if (t.classList.contains('vid-unpin')) {
      post('/action/unpin-video', { 'map-name': sec.dataset.map, 'node-id': sec.dataset.node, video: t.dataset.video })
        .then(function (r) {
          if (!r.ok) return;
          var li = pinned(sec, t.dataset.video); if (li) li.remove();
          syncPinned(sec);
          sec.querySelectorAll('.vid-pin[data-video="' + t.dataset.video + '"]').forEach(function (b) {
            setPin(b, 'idle');
          });
        });
    }
  });

  document.addEventListener('submit', function (e) {
    var form = e.target.closest && e.target.closest('.vid-search');
    if (!form) return;
    e.preventDefault();
    var q = form.elements.q.value.trim();
    if (q) runSearch(form.closest('.videos'), q);
  });
})();
