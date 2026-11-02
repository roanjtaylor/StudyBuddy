// A "thinking…" state while a form that talks to the model is in flight
// (Ctrl/Cmd+Enter submits). The Claude dock is dock.js. The drawings are static
// sheets: nothing here pans or zooms them.
//
// Opening an idea (a link to /field?idea=…) does not leave the page: the idea's detail is
// fetched and swapped in below the timeline and outline, which stay where they are.
(function () {
  function wireForms(root) {
    root.querySelectorAll('form:not(.dock-form)').forEach(function (form) {
      form.addEventListener('submit', function () { form.classList.add('pending'); });
      form.querySelectorAll('textarea').forEach(function (ta) {
        ta.addEventListener('keydown', function (e) {
          if ((e.ctrlKey || e.metaKey) && e.key === 'Enter') { e.preventDefault(); form.requestSubmit(); }
        });
      });
    });
  }
  wireForms(document);

  var grid = document.querySelector('.stage.grid');
  if (!grid) return;

  function load(url, push) {
    return fetch(url, { headers: { 'X-Requested-With': 'fetch' } })
      .then(function (r) { if (!r.ok) throw new Error(r.status); return r.text(); })
      .then(function (text) {
        var doc = new DOMParser().parseFromString(text, 'text/html');
        if (!doc.getElementById('idea')) { location.href = url; return; }
        // Swap the idea and the writing box; the chat on the right stays as it is.
        ['.idea-main', '.idea-write'].forEach(function (sel) {
          var mine = document.querySelector(sel), theirs = doc.querySelector(sel);
          if (!mine || !theirs) return;
          var fresh = document.importNode(theirs, true);
          mine.replaceWith(fresh);
          wireForms(fresh);
        });
        var node = document.getElementById('idea');

        // Open the groups the new idea sits in; leave the ones the learner opened.
        ['.outline-group', '.tl-group'].forEach(function (sel) {
          var theirs = doc.querySelectorAll(sel), mine = document.querySelectorAll(sel);
          theirs.forEach(function (d, i) { if (d.open && mine[i]) mine[i].open = true; });
        });

        // The crumbs, the title, and what the dock is looking at.
        var nav = document.querySelector('nav.top'), newNav = doc.querySelector('nav.top');
        if (nav && newNav) nav.innerHTML = newNav.innerHTML;
        document.title = doc.title;
        // The chat under the idea now looks at the new idea (unless it is hanging from a section).
        var form = document.getElementById('dock-form'), newForm = doc.getElementById('dock-form');
        if (form && newForm) {
          form.dataset.homeHere = newForm.elements.here.value;
          form.dataset.homeLabel = newForm.querySelector('.pill-text').textContent;
          if (!document.getElementById('dock').classList.contains('popover')) {
            form.elements.here.value = form.dataset.homeHere;
            form.querySelector('.pill-text').textContent = form.dataset.homeLabel;
          }
        }

        if (push) history.pushState(null, '', url);
        // Bring the detail into view only if it is down below the fold.
        var top = node.getBoundingClientRect().top;
        if (top > window.innerHeight * 0.6) {
          var scroller = document.querySelector('main');
          var by = top - window.innerHeight * 0.4;
          (scroller && scroller.scrollHeight > scroller.clientHeight ? scroller : window)
            .scrollBy({ top: by, behavior: 'smooth' });
        }
      })
      .catch(function () { location.href = url; });
  }

  document.addEventListener('click', function (e) {
    var a = e.target.closest && e.target.closest('a[href*="?idea="]');
    if (!a || e.defaultPrevented || e.button !== 0 || e.metaKey || e.ctrlKey || e.shiftKey || a.target) return;
    var u = new URL(a.href, location.href);
    if (u.origin !== location.origin || u.pathname !== location.pathname) return;
    e.preventDefault();
    u.hash = '';
    load(u.pathname + u.search, true);
  });

  window.addEventListener('popstate', function () { load(location.pathname + location.search, false); });
})();
