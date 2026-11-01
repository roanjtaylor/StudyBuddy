// The app's own viewers for two kinds of artifact the model makes as data, not markup:
// flashcards (flip, mark known, shuffle) and a quiz (pick, reveal, score). The data is
// in #data as JSON; #app says which kind. Progress is kept per artifact in localStorage.
(function () {
  var app = document.getElementById('app');
  var data = JSON.parse(document.getElementById('data').textContent || '[]');
  var kind = app.dataset.kind, id = app.dataset.id;

  function keep(key, value) {
    try { if (value === undefined) return localStorage.getItem(key); localStorage.setItem(key, value); } catch (e) {}
  }
  function el(tag, cls, text) {
    var e = document.createElement(tag);
    if (cls) e.className = cls;
    if (text !== undefined) e.textContent = text;
    return e;
  }
  function rich(e, text) { e.innerHTML = window.md ? md.render(text || '') : '<p></p>'; if (!window.md) e.textContent = text || ''; }

  // ---- Flashcards ----
  function flashcards(cards) {
    var known = {}; try { known = JSON.parse(keep('cards-known-' + id) || '{}'); } catch (e) {}
    var order = cards.map(function (_, i) { return i; }), at = 0, flipped = false;

    var top = el('div', 'bar');
    var count = el('span', 'count'); top.appendChild(count);
    var gap = el('span', 'gap'); top.appendChild(gap);
    var shuffle = el('button', '', 'Shuffle'); top.appendChild(shuffle);
    var reset = el('button', '', 'Reset'); top.appendChild(reset);
    var card = el('div', 'card');
    var front = el('div', 'face front md'), back = el('div', 'face back md');
    card.appendChild(front); card.appendChild(back);
    var hint = el('p', 'quiet small', 'Click or press space to flip · ← → to move');
    var row = el('div', 'row');
    var again = el('button', 'again', 'Again'); var got = el('button', 'got', 'Got it');
    row.appendChild(again); row.appendChild(got);
    app.appendChild(top); app.appendChild(card); app.appendChild(row); app.appendChild(hint);

    function draw() {
      var c = cards[order[at]];
      rich(front, c.front); rich(back, c.back);
      card.classList.toggle('flipped', flipped);
      card.classList.toggle('known', !!known[order[at]]);
      var n = Object.keys(known).filter(function (k) { return known[k]; }).length;
      count.textContent = (at + 1) + ' / ' + cards.length + ' · ' + n + ' known';
    }
    function move(d) { at = (at + d + order.length) % order.length; flipped = false; draw(); }
    function flip() { flipped = !flipped; draw(); }
    card.addEventListener('click', flip);
    document.addEventListener('keydown', function (e) {
      if (e.key === ' ') { e.preventDefault(); flip(); }
      else if (e.key === 'ArrowRight') move(1);
      else if (e.key === 'ArrowLeft') move(-1);
    });
    got.addEventListener('click', function () { known[order[at]] = true; keep('cards-known-' + id, JSON.stringify(known)); move(1); });
    again.addEventListener('click', function () { known[order[at]] = false; keep('cards-known-' + id, JSON.stringify(known)); move(1); });
    shuffle.addEventListener('click', function () {
      for (var i = order.length - 1; i > 0; i--) { var j = Math.floor(Math.random() * (i + 1)); var t = order[i]; order[i] = order[j]; order[j] = t; }
      at = 0; flipped = false; draw();
    });
    reset.addEventListener('click', function () { known = {}; keep('cards-known-' + id, '{}'); draw(); });
    draw();
  }

  // ---- Quiz ----
  function quiz(questions) {
    var at = 0, score = 0, picked = null;
    var bar = el('div', 'bar'); var count = el('span', 'count'); bar.appendChild(count);
    var q = el('div', 'question md'); var opts = el('div', 'options');
    var why = el('div', 'why md'); why.hidden = true;
    var row = el('div', 'row'); var next = el('button', 'primary', 'Next'); next.hidden = true; row.appendChild(next);
    app.appendChild(bar); app.appendChild(q); app.appendChild(opts); app.appendChild(why); app.appendChild(row);

    function draw() {
      var it = questions[at]; picked = null;
      count.textContent = 'Question ' + (at + 1) + ' of ' + questions.length + ' · ' + score + ' right';
      rich(q, it.question); opts.innerHTML = ''; why.hidden = true; next.hidden = true;
      it.options.forEach(function (o, i) {
        var b = el('button', 'option'); rich(b, o);
        b.addEventListener('click', function () { pick(i); });
        opts.appendChild(b);
      });
    }
    function pick(i) {
      if (picked !== null) return;
      picked = i;
      var it = questions[at];
      if (i === it.answer) score++;
      Array.prototype.forEach.call(opts.children, function (b, j) {
        b.classList.toggle('right', j === it.answer);
        b.classList.toggle('wrong', j === i && i !== it.answer);
        b.disabled = true;
      });
      rich(why, (i === it.answer ? '**Right.** ' : '**Not quite.** ') + (it.explanation || ''));
      why.hidden = false;
      next.textContent = at + 1 < questions.length ? 'Next' : 'See score';
      next.hidden = false;
      count.textContent = 'Question ' + (at + 1) + ' of ' + questions.length + ' · ' + score + ' right';
    }
    function finish() {
      app.innerHTML = '';
      var h = el('h1', '', score + ' / ' + questions.length);
      var p = el('p', 'quiet', score === questions.length ? 'All of them.' : 'Write out the ones you missed; that is where the gap is.');
      var again = el('button', 'primary', 'Again');
      again.addEventListener('click', function () { app.innerHTML = ''; at = 0; score = 0; quiz(questions); });
      app.appendChild(h); app.appendChild(p); app.appendChild(again);
      keep('quiz-best-' + id, String(Math.max(score, Number(keep('quiz-best-' + id) || 0))));
    }
    next.addEventListener('click', function () { if (at + 1 < questions.length) { at++; draw(); } else finish(); });
    draw();
  }

  if (kind === 'flashcards') flashcards(data);
  else if (kind === 'quiz') quiz(data);
})();
