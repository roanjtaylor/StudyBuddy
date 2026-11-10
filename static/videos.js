// Images and videos for an idea. A centred "Browse" button at the foot of the idea opens a
// panel: one search bar, images on the left (Wikimedia Commons), YouTube videos on the right,
// both loaded for the idea's title and searchable again. Anything can be pinned; pins sit in a
// tray at the foot of the idea (.pin-tray, drawn by the server): "Images:" and "Videos:".
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
  function tray() { return document.querySelector('.pin-tray'); }
  function pinnedVideo(id) { var t = tray(); return t && t.querySelector('.pin-videos [data-video="' + id + '"]'); }
  function pinnedImage(key) { var t = tray(); return t && t.querySelector('.pin-images [data-image="' + key + '"]'); }

  // Full screen: a click on any image or video preview shows it over the page, which is greyed
  // behind it. A "Source" link sits left of the ✕; Esc, the ✕ or a click outside closes it.
  //   {image: thumbnailUrl, title, source}   or   {video: id, title, source}
  function fullScreen(item) {
    var box = el('div', 'pin-lightbox'), bar = el('div', 'pin-lightbox-bar'), body;
    var src = el('a', 'pin-lightbox-src', 'Source ↗'), x = el('button', 'pin-lightbox-x', '✕');
    src.href = item.source; src.target = '_blank'; src.rel = 'noopener'; src.title = item.title || '';
    x.type = 'button'; x.title = 'Close'; x.setAttribute('aria-label', 'Close');
    if (item.image) {
      body = el('img'); body.alt = item.title || '';
      // A larger rendering of the same picture; the thumbnail stands in if Commons has none that big.
      body.onerror = function () { body.onerror = null; body.src = item.image; };
      body.src = item.image.replace(/\/\d+px-/, '/1280px-');
    } else {
      body = el('iframe');
      body.src = 'https://www.youtube-nocookie.com/embed/' + encodeURIComponent(item.video) + '?autoplay=1&rel=0';
      body.title = item.title || 'YouTube video'; body.allowFullscreen = true;
      body.allow = 'autoplay; encrypted-media; picture-in-picture; fullscreen';
      body.referrerPolicy = 'strict-origin-when-cross-origin';
    }
    function close() { box.remove(); document.body.classList.remove('pin-lightboxed'); document.removeEventListener('keydown', onKey); }
    function onKey(e) { if (e.key === 'Escape') close(); }
    box.addEventListener('click', function (e) { if (e.target !== body && !bar.contains(e.target)) close(); });
    x.addEventListener('click', close);
    document.addEventListener('keydown', onKey);
    bar.appendChild(src); bar.appendChild(x);
    box.appendChild(body); box.appendChild(bar);
    document.body.appendChild(box); document.body.classList.add('pin-lightboxed');
    x.focus();
  }

  function syncTray() {
    var t = tray(); if (!t) return;
    var any = false;
    t.querySelectorAll('.pin-group').forEach(function (g) {
      var has = g.querySelector('.pin-list').children.length > 0;
      g.hidden = !has; any = any || has;
    });
    t.hidden = !any;
  }

  var PIN = '<svg viewBox="0 0 24 24" width="16" height="16" fill="currentColor" aria-hidden="true"><path d="M16 3a1 1 0 0 1 .7 1.7L15.4 6l1.8 5.4 1.5 1.5a1 1 0 0 1-.7 1.7H13v5.3l-1 2-1-2v-5.3H6a1 1 0 0 1-.7-1.7l1.5-1.5L8.6 6 7.3 4.7A1 1 0 0 1 8 3z"/></svg>';
  function setPin(btn, state) {
    btn.disabled = state !== 'idle';
    btn.classList.toggle('pinned', state === 'pinned');
    btn.innerHTML = PIN + '<span>' + (state === 'pinned' ? 'Pinned' : state === 'busy' ? 'Pinning…' : 'Pin') + '</span>';
    btn.title = state === 'pinned' ? 'Pinned beside the chat' : 'Pin beside the chat';
  }
  function pinButton(cls, data, isPinned) {
    var b = el('button', cls); b.type = 'button';
    Object.keys(data).forEach(function (k) { b.dataset[k] = data[k]; });
    setPin(b, isPinned ? 'pinned' : 'idle');
    return b;
  }

  // A video result laid out as YouTube does: a large thumbnail, then channel avatar, title and
  // channel / views underneath, with the pin inside the card.
  function videoResult(r) {
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
    var pin = pinButton('vid-pin', { video: r.video, title: r.title, channel: r.channel || '' }, pinnedVideo(r.video));
    info.appendChild(av); info.appendChild(text);
    li.appendChild(thumb); li.appendChild(pin); li.appendChild(info);
    return li;
  }

  // An image result: the picture (opens its Commons page), its name, and a pin over its corner.
  function imageResult(r) {
    var li = el('li', 'img-result');
    var link = el('a', 'img-link'); link.href = r.page; link.target = '_blank'; link.rel = 'noopener'; link.title = r.title;
    var img = el('img'); img.alt = r.title; img.loading = 'lazy'; img.src = r.thumb;
    link.appendChild(img);
    var pin = pinButton('img-pin', { key: r.key, title: r.title, thumb: r.thumb, page: r.page }, pinnedImage(r.key));
    li.appendChild(link); li.appendChild(pin); li.appendChild(el('span', 'img-name', r.title));
    return li;
  }

  // Each column has its own search bar. A newer search in a column replaces an older one still in flight.
  var COLUMNS = {
    images: { sel: '.browse-images', url: '/action/image-search', build: imageResult, none: 'No images found.',
              dflt: function (title) { return title; } },
    videos: { sel: '.browse-videos', url: '/action/video-search', build: videoResult, none: 'No videos found.',
              dflt: function (title) { return title + ' explained'; } }
  };
  function runSearch(sec, kind, q) {
    var c = COLUMNS[kind], tokens = sec._search || (sec._search = {}), token = tokens[kind] = (tokens[kind] || 0) + 1;
    var col = sec.querySelector(c.sel), status = col.querySelector('.col-status'), list = col.querySelector('ul');
    status.textContent = 'Searching…'; list.innerHTML = '';
    return post(c.url, { q: q })
      .then(function (r) {
        if (token !== tokens[kind]) return;
        if (!r.ok) { status.textContent = r.error || 'Search failed.'; return; }
        status.textContent = r.results.length ? '' : c.none;
        r.results.forEach(function (x) { list.appendChild(c.build(x)); });
      })
      .catch(function () { if (token === tokens[kind]) status.textContent = 'Search failed.'; });
  }

  function addToTray(html) {
    var t = tray(); if (!t) return;
    var w = document.createElement('ul'); w.innerHTML = html;
    var item = w.firstElementChild; if (!item) return;
    t.querySelector(item.classList.contains('pin-art') ? '.pin-artifacts .pin-list' : item.classList.contains('pin-img') ? '.pin-images .pin-list' : '.pin-videos .pin-list').appendChild(item);
    syncTray();
  }

  // Pin or unpin an artifact (its pin button, wherever it is shown) to the open idea.
  function markPinned(id, on) {
    document.querySelectorAll('.artifact-pin[data-artifact="' + id + '"]').forEach(function (b) {
      b.classList.toggle('pinned', on); b.setAttribute('aria-pressed', String(on));
      b.title = on ? 'Pinned to this idea; click to unpin' : 'Pin to this idea';
    });
  }
  function unpinArtifact(id) {
    var t = tray(); if (!t) return;
    post('/action/unpin-artifact', { 'map-name': t.dataset.map, id: id }).then(function (r) {
      if (!r.ok) return;
      var li = t.querySelector('.pin-artifacts [data-artifact="' + id + '"]'); if (li) li.remove();
      syncTray(); markPinned(id, false);
    });
  }
  function pinArtifact(btn) {
    var id = btn.dataset.artifact;
    if (btn.classList.contains('pinned')) { unpinArtifact(id); return; }
    var t = tray(); if (!t) return;
    post('/action/pin-artifact', { 'map-name': t.dataset.map, 'node-id': t.dataset.node, id: id }).then(function (r) {
      if (!r.ok) return;
      var old = t.querySelector('.pin-artifacts [data-artifact="' + id + '"]'); if (old) old.remove();
      addToTray(r.html); markPinned(id, true);
    });
  }

  document.addEventListener('click', function (e) {
    var pa = e.target.closest && e.target.closest('.artifact-pin');
    if (pa) { pinArtifact(pa); return; }
    var t = e.target.closest && e.target.closest('.videos button, .pin-tray button');
    if (!t) return;
    var sec = t.closest('.videos');

    if (t.classList.contains('browse-open')) {
      var browse = sec.querySelector('.browse');
      browse.hidden = !browse.hidden;
      t.setAttribute('aria-expanded', String(!browse.hidden));
      if (!browse.hidden) {
        // The first time, each bar is filled with a search for the idea itself and run; each stays editable on its own.
        if (!browse.dataset.searched) {
          browse.dataset.searched = '1';
          var title = sec.dataset.title || '';
          if (title) Object.keys(COLUMNS).forEach(function (kind) {
            var box = sec.querySelector(COLUMNS[kind].sel + ' input');
            box.value = COLUMNS[kind].dflt(title);
            runSearch(sec, kind, box.value);
          });
        }
        browse.scrollIntoView({ block: 'nearest', behavior: 'smooth' });
        browse.querySelector('input').focus();
      }
    } else if (t.classList.contains('vid-play')) {
      fullScreen({ video: t.dataset.video, title: t.dataset.title, source: 'https://www.youtube.com/watch?v=' + encodeURIComponent(t.dataset.video) });
    } else if (t.classList.contains('vid-pin') || t.classList.contains('img-pin')) {
      var video = t.classList.contains('vid-pin');
      setPin(t, 'busy');
      var data = { 'map-name': sec.dataset.map, 'node-id': sec.dataset.node };
      if (video) { data.video = t.dataset.video; data.title = t.dataset.title; data.channel = t.dataset.channel; }
      else { data.key = t.dataset.key; data.title = t.dataset.title; data.thumb = t.dataset.thumb; data.page = t.dataset.page; }
      post(video ? '/action/pin-video' : '/action/pin-image', data)
        .then(function (r) {
          if (!r.ok) throw new Error(r.error);
          if (!(video ? pinnedVideo(t.dataset.video) : pinnedImage(t.dataset.key))) addToTray(r.html);
          setPin(t, 'pinned');
        })
        .catch(function () { setPin(t, 'idle'); });
    } else if (t.classList.contains('pin-remove')) {
      var tr = t.closest('.pin-tray'), isVideo = t.dataset.kind === 'video', key = t.dataset.key;
      if (t.dataset.kind === 'artifact') { unpinArtifact(key); return; }
      post(isVideo ? '/action/unpin-video' : '/action/unpin-image',
           isVideo ? { 'map-name': tr.dataset.map, 'node-id': tr.dataset.node, video: key }
                   : { 'map-name': tr.dataset.map, 'node-id': tr.dataset.node, key: key })
        .then(function (r) {
          if (!r.ok) return;
          var li = t.closest('li'); if (li) li.remove();
          syncTray();
          document.querySelectorAll(isVideo ? '.vid-pin[data-video="' + key + '"]' : '.img-pin[data-key="' + key + '"]')
            .forEach(function (b) { setPin(b, 'idle'); });
        });
    }
  });

  // A click on an image preview, in the results or among the pins, opens it full screen too.
  document.addEventListener('click', function (e) {
    var a = e.target.closest && e.target.closest('.img-link, .pin-img-link');
    if (!a || e.ctrlKey || e.metaKey || e.shiftKey || e.button) return;
    e.preventDefault();
    var img = a.querySelector('img');
    fullScreen({ image: img.src, title: img.alt, source: a.href });
  });

  document.addEventListener('submit', function (e) {
    var form = e.target.closest && e.target.closest('.browse-search');
    if (!form) return;
    e.preventDefault();
    var q = form.elements.q.value.trim();
    if (q) runSearch(form.closest('.videos'), form.dataset.kind, q);
  });
})();
