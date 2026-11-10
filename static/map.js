// A "thinking…" state while a form that talks to the model is in flight
// (Ctrl/Cmd+Enter submits). The Claude dock is dock.js. The drawings are static
// sheets: nothing here pans or zooms them.
//
// Opening an idea (a link to /field/idea) does not leave the page: the idea's detail is
// fetched and swapped in below the timeline, which stays where they are.
(function () {
  function wireForms(root) {
    root.querySelectorAll('form:not(.dock-form):not(.browse-search)').forEach(function (form) {
      form.addEventListener('submit', function () { form.classList.add('pending'); });
      form.querySelectorAll('textarea').forEach(function (ta) {
        ta.addEventListener('keydown', function (e) {
          if ((e.ctrlKey || e.metaKey) && e.key === 'Enter') { e.preventDefault(); form.requestSubmit(); }
        });
      });
    });
  }
  wireForms(document);

  // An artifact's bin: a click adds "Delete? Delete / Cancel" beside it; only that Delete deletes.
  document.addEventListener('click', function (e) {
    var b = e.target.closest && e.target.closest('.artifact-del, .artifact-del-no');
    if (!b) return;
    var form = b.closest('.artifact-del-form'), bin = form.querySelector('.artifact-del'),
        ask = form.querySelector('.artifact-del-confirm');
    ask.hidden = b !== bin || !ask.hidden;
    bin.setAttribute('aria-expanded', String(!ask.hidden));
  });

  // While a chat is answering, nothing may navigate the page away from it: a link click is
  // held (in the capture phase, before anything else sees it) until the reply is finished, and
  // leaving by other means asks first. The field chat streams from this very page.
  document.addEventListener('click', function (e) {
    if (!anyBusy()) return;
    var a = e.target.closest && e.target.closest('a[href]');
    if (!a || a.target || e.button !== 0) return;
    var href = a.getAttribute('href') || '';
    if (!href || href.charAt(0) === '#' || a.closest('.artifact-inline, .artifact-card')) return;
    e.preventDefault(); e.stopPropagation();
    toast('A chat is still answering — try again when it finishes.');
  }, true);
  window.addEventListener('beforeunload', function (e) {
    if (anyBusy()) { e.preventDefault(); e.returnValue = ''; }
  });

  var grid = document.querySelector('.stage.grid');
  if (!grid) return;

  // The two chats are independent: the field chat (dock.js) lives outside everything this file
  // swaps, so it keeps streaming while ideas are opened. The study chat belongs to the open
  // idea, so while it is answering the idea cannot change under it.
  function studyBusy() { return !!document.querySelector('.study-form.busy'); }
  function anyBusy() { return studyBusy() || !!document.querySelector('#dock-form.busy'); }
  var toastTimer = null;
  function toast(text) {
    var t = document.getElementById('busy-toast');
    if (!t) { t = document.createElement('div'); t.id = 'busy-toast'; t.setAttribute('role', 'status'); document.body.appendChild(t); }
    t.textContent = text; t.classList.add('show');
    clearTimeout(toastTimer); toastTimer = setTimeout(function () { t.classList.remove('show'); }, 2600);
  }
  // A normal visit would drop a chat that is still answering, so say so instead.
  function visit(url) {
    if (anyBusy()) toast('A chat is still answering — try again when it finishes.');
    else location.href = url;
  }

  // keepStudy: refresh the idea in place (after an approved edit) without touching the study chat.
  function load(url, push, keepStudy) {
    return fetch(url, { headers: { 'X-Requested-With': 'fetch' } })
      .then(function (r) { if (!r.ok) throw new Error(r.status); return r.text(); })
      .then(function (text) {
        var doc = new DOMParser().parseFromString(text, 'text/html');
        if (!doc.getElementById('idea')) { visit(url); return; }
        // Swap the idea and the writing box; the chat on the right stays as it is.
        (keepStudy ? ['.idea-main'] : ['.idea-main', '.idea-study']).forEach(function (sel) {
          var mine = document.querySelector(sel), theirs = doc.querySelector(sel);
          if (!mine || !theirs) return;
          var fresh = document.importNode(theirs, true);
          mine.replaceWith(fresh);
          wireForms(fresh);
        });
        // The study chat shows only with an idea open.
        var side = document.querySelector('#idea .idea-side'), newSide = doc.querySelector('#idea .idea-side');
        if (side && newSide) side.classList.toggle('has-idea', newSide.classList.contains('has-idea'));
        var node = document.getElementById('idea');

        // Open the groups the new idea sits in; leave the ones the learner opened.
        ['.tl-group'].forEach(function (sel) {
          var theirs = doc.querySelectorAll(sel), mine = document.querySelectorAll(sel);
          theirs.forEach(function (d, i) { if (d.open && mine[i]) mine[i].open = true; });
        });

        // The crumbs, the title, and what the dock is looking at.
        var nav = document.querySelector('nav.top'), newNav = doc.querySelector('nav.top');
        if (nav && newNav) nav.innerHTML = newNav.innerHTML;
        document.title = doc.title;
        // The field chat now looks at the new idea.
        var form = document.getElementById('dock-form'), newForm = doc.getElementById('dock-form');
        if (form && newForm) {
          form.elements.here.value = newForm.elements.here.value;
          form.querySelector('.pill-text').textContent = newForm.querySelector('.pill-text').textContent;
        }

        if (keepStudy) return;
        document.dispatchEvent(new Event('idea-swapped'));
        if (push) history.pushState(null, '', url);
      })
      .catch(function () { visit(url); });
  }

  window.refreshIdea =function () { return load(location.pathname + location.search, false, true); };

  // An idea is /field/idea. Any link of that shape within this field opens in place; if the
  // answer turns out not to be an idea, load() falls back to a normal visit.
  function segments(path) { return path.split('/').filter(Boolean); }
  document.addEventListener('click', function (e) {
    var a = e.target.closest && e.target.closest('a[href]');
    if (!a || e.defaultPrevented || e.button !== 0 || e.metaKey || e.ctrlKey || e.shiftKey || a.target) return;
    var u = new URL(a.getAttribute('href'), location.href);   // not a.href: on an SVG link that is not a string
    var here = segments(location.pathname), there = segments(u.pathname);
    if (u.origin !== location.origin || there.length !== 2 || here[0] !== there[0]) return;
    e.preventDefault();
    if (studyBusy()) { toast('The study chat is still answering — wait for it to finish before opening another idea.'); return; }
    u.hash = '';
    load(u.pathname + u.search, true);
  });

  window.addEventListener('popstate', function () { load(location.pathname + location.search, false); });
})();
