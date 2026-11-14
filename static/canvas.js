// The stage as a whiteboard: an artifact opened on the stage (?stage=1) never scrolls.
// It is laid out as usual, then the whole page is scaled to fit the frame; the wheel zooms
// about the pointer and a drag on anything that is not a control pans. All of it happens
// in here, on the root element's transform, so the frame keeps its size (and 100vh its
// meaning). A thumbnail (in the chat, an idea's tiles, the pins) is fitted the same way when
// the page holding it asks, but is not zoomed or panned.
//   to the page holding the frame:   {artifactZoom: k}   whenever the view changes
//   from it:                         {artifactView: 'fit'}   back to the whole thing
//                                    {artifactView: 'thumb'}  fit only: this is a thumbnail
(function () {
  if (window.parent === window) return;
  var stage = /[?&]stage=1/.test(location.search), on = false;
  var root = document.documentElement;
  var k = 1, tx = 0, ty = 0;
  var free = false;          // moved by hand: stop refitting when the content changes size
  var seen = '';


  // The page's own size, as laid out: none of these are changed by the transform.
  function size() {
    var b = document.body, w = root.offsetWidth, h = root.offsetHeight;
    if (b) {
      var cs = getComputedStyle(b);
      w = Math.max(w, (parseFloat(cs.marginLeft) || 0) + b.scrollWidth);
      h = Math.max(h, (parseFloat(cs.marginTop) || 0) + b.scrollHeight + (parseFloat(cs.marginBottom) || 0));
    }
    return { w: Math.max(w, 1), h: Math.max(h, 1), vw: window.innerWidth, vh: window.innerHeight };
  }
  function fitScale(s) {
    var f = Math.min(1, s.vw / s.w, s.vh / s.h);
    return f > .99 ? 1 : f;
  }
  function apply() {
    root.style.transform = (k === 1 && !tx && !ty) ? '' : 'translate(' + tx + 'px,' + ty + 'px) scale(' + k + ')';
    parent.postMessage({ artifactZoom: k }, '*');
  }
  // All of it in view: full size if it fits, else scaled down and centred.
  function fit() {
    var s = size();
    k = fitScale(s);
    tx = Math.max(0, (s.vw - s.w * k) / 2); ty = 0;
    free = false;
    seen = [s.w, s.h, s.vw, s.vh].join();
    apply();
  }
  function refit() {
    if (free) return;
    var s = size();
    if ([s.w, s.h, s.vw, s.vh].join() !== seen) fit();
  }
  function zoomAt(x, y, by) {
    var to = Math.max(Math.min(.2, fitScale(size())), Math.min(8, k * by));
    tx = x - (x - tx) * to / k; ty = y - (y - ty) * to / k;
    k = to; free = true;
    apply();
  }

  function interact() {
  // ---- Wheel: zoom about the pointer (a list or code block that scrolls keeps its wheel) ----
  function scrolls(t) {
    for (var e = t; e && e.nodeType === 1 && e !== document.body && e !== root; e = e.parentNode) {
      if (e.scrollHeight > e.clientHeight + 1 && /auto|scroll/.test(getComputedStyle(e).overflowY)) return true;
    }
    return false;
  }
  window.addEventListener('wheel', function (e) {
    if (!e.ctrlKey && scrolls(e.target)) return;
    e.preventDefault();
    var d = e.deltaY * (e.deltaMode === 1 ? 16 : 1);
    zoomAt(e.clientX, e.clientY, Math.exp(-d * (e.ctrlKey ? .01 : .0015)));
  }, { passive: false });

  // ---- Drag: pan, unless it starts on something of the artifact's own to click or drag ----
  var controls = 'a,button,input,select,textarea,label,summary,option,[onclick],[onmousedown],[onpointerdown],[draggable="true"],[contenteditable]';
  function busy(t) {
    if (!t || t.nodeType !== 1) return false;
    if (t.closest(controls)) return true;
    return !/^(auto|default|text)$/.test(getComputedStyle(t).cursor);   // pointer, grab, move…: the artifact's
  }
  var pts = {}, drag = null, pinch = null;
  function two() {
    var p = Object.keys(pts).map(function (i) { return pts[i]; });
    return { d: Math.hypot(p[0].x - p[1].x, p[0].y - p[1].y) || 1, x: (p[0].x + p[1].x) / 2, y: (p[0].y + p[1].y) / 2 };
  }
  function eat(e) { e.stopPropagation(); e.preventDefault(); }
  function endDrag() {
    if (drag && drag.moved) {
      root.classList.remove('sb-pan');
      // The click that ends a drag is not a click on what was under it.
      window.addEventListener('click', eat, true);
      setTimeout(function () { window.removeEventListener('click', eat, true); }, 0);
    }
    drag = null;
  }
  window.addEventListener('pointerdown', function (e) {
    pts[e.pointerId] = { x: e.clientX, y: e.clientY };
    if (Object.keys(pts).length === 2) { endDrag(); pinch = two(); return; }
    if (e.defaultPrevented) return;
    if (e.button === 1 || (e.button === 0 && !busy(e.target))) {
      drag = { id: e.pointerId, x: e.clientX, y: e.clientY, tx: tx, ty: ty, moved: false };
      if (e.button === 1) e.preventDefault();   // no autoscroll puck
    }
  });
  window.addEventListener('pointermove', function (e) {
    if (pts[e.pointerId]) pts[e.pointerId] = { x: e.clientX, y: e.clientY };
    if (pinch && Object.keys(pts).length === 2) {
      var now = two();
      tx += now.x - pinch.x; ty += now.y - pinch.y;
      zoomAt(now.x, now.y, now.d / pinch.d);
      pinch = now;
      return;
    }
    if (!drag || e.pointerId !== drag.id) return;
    var dx = e.clientX - drag.x, dy = e.clientY - drag.y;
    if (!drag.moved) {
      if (Math.hypot(dx, dy) < 4) return;
      drag.moved = true;
      root.classList.add('sb-pan');
      try { root.setPointerCapture(e.pointerId); } catch (err) {}
      var sel = window.getSelection && window.getSelection(); if (sel) sel.removeAllRanges();
    }
    tx = drag.tx + dx; ty = drag.ty + dy; free = true;
    apply();
  });
  function up(e) {
    delete pts[e.pointerId];
    if (Object.keys(pts).length < 2) pinch = null;
    if (drag && e.pointerId === drag.id) endDrag();
  }
  window.addEventListener('pointerup', up);
  window.addEventListener('pointercancel', up);
  window.addEventListener('dragstart', function (e) { if (drag) e.preventDefault(); });

  // Anything that scrolls the page anyway (a focus, a #link) becomes a pan instead.
  window.addEventListener('scroll', function () {
    if (!window.scrollX && !window.scrollY) return;
    tx -= window.scrollX; ty -= window.scrollY; free = true;
    window.scrollTo(0, 0);
    apply();
  });

  }

  // Fit now, and again whenever the content or the frame changes size, until moved by hand.
  function start() {
    if (on) return;
    on = true;
    var style = document.createElement('style');
    style.textContent =
      'html{overflow:hidden!important;transform-origin:0 0!important;touch-action:none}' +
      'html.sb-pan,html.sb-pan *{cursor:grabbing!important;user-select:none!important;-webkit-user-select:none!important}';
    (document.head || root).appendChild(style);
    window.addEventListener('load', refit);
    window.addEventListener('resize', refit);
    if (window.ResizeObserver) {
      var ro = new ResizeObserver(refit);
      ro.observe(root); if (document.body) ro.observe(document.body);
    }
    setInterval(refit, 500);
    fit();
  }

  window.addEventListener('message', function (e) {
    if (e.source !== parent || !e.data) return;
    if (e.data.artifactView === 'fit' && on) fit();
    // A thumbnail: the page holding it asks for the whole artifact, fitted, and nothing more.
    if (e.data.artifactView === 'thumb') start();
  });
  if (stage) { interact(); start(); }
  // A preview: say so (with the height, as the artifact view does), in case the first report
  // went out before this script was listening for the answer.
  else parent.postMessage({ artifactHeight: Math.ceil(Math.max(root.scrollHeight, document.body ? document.body.scrollHeight : 0)) || 1 }, '*');
})();
