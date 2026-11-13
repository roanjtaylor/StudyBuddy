// What the model is making, shown while it is still being written. A tool call's input
// (an artifact's content, a proposed body) arrives as pieces of unfinished JSON: `draft`
// events {id, tool} to begin, {id, partial} per piece, {id, done} when the input is whole.
// Each call gets a block in the live reply that is redrawn as the pieces come, so the
// learner reads while the rest is written. Shared by the dock (dock.js) and the study
// pane (study.js); the blocks go when the finished reply replaces the live one.
(function () {
  if (!window.md) return;

  // Parse JSON that stops anywhere: whatever is complete, plus the string being written.
  // parsePartial('{"title":"Lat') → {title: "Lat"}
  function parsePartial(s) {
    var i = 0, n = s.length;
    function ws() { while (i < n && (s[i] === ' ' || s[i] === '\n' || s[i] === '\t' || s[i] === '\r')) i++; }
    function string() {
      var out = '', from = ++i;
      while (i < n) {
        var c = s[i];
        if (c === '"') { out += s.slice(from, i); i++; return out; }
        if (c === '\\') {
          out += s.slice(from, i);
          var e = s[i + 1];
          if (e === undefined || (e === 'u' && i + 6 > n)) { i = n; return out; }   // cut mid-escape
          if (e === 'u') { out += String.fromCharCode(parseInt(s.substr(i + 2, 4), 16) || 32); i += 6; }
          else { out += ({ n: '\n', t: '\t', r: '\r', b: '\b', f: '\f' })[e] || e; i += 2; }
          from = i;
        } else i++;
      }
      return out + s.slice(from, n);
    }
    function object() {
      var o = {}; i++;
      while (i < n) {
        ws();
        if (s[i] === '}') { i++; break; }
        if (s[i] === ',') { i++; continue; }
        if (s[i] !== '"') break;
        var key = string(); ws();
        if (s[i] !== ':') break;            // the key itself is still being written
        i++;
        var v = value();
        if (v !== undefined) o[key] = v;
      }
      return o;
    }
    function array() {
      var a = []; i++;
      while (i < n) {
        ws();
        if (s[i] === ']') { i++; break; }
        if (s[i] === ',') { i++; continue; }
        var v = value();
        if (v === undefined) break;
        a.push(v);
      }
      return a;
    }
    function value() {
      ws();
      if (i >= n) return undefined;
      var c = s[i];
      if (c === '{') return object();
      if (c === '[') return array();
      if (c === '"') return string();
      var m = /^(-?\d+(\.\d+)?([eE][-+]?\d+)?|true|false|null)/.exec(s.slice(i, i + 40));
      if (!m) { i = n; return undefined; }
      i += m[0].length;
      return m[0] === 'true' ? true : m[0] === 'false' ? false : m[0] === 'null' ? null : Number(m[0]);
    }
    return value();
  }

  function list(x) { return Array.isArray(x) ? x : []; }
  function text(x) { return typeof x === 'string' ? x : ''; }

  // What to show for a call so far: {label, md} for prose, {label, code} for source.
  // Tools with nothing worth reading (read_node, read_artifact) get no block.
  var views = {
    create_artifact: function (o) {
      var label = 'Writing ' + (o.title ? '“' + o.title + '”' : 'an artifact');
      return o.type === 'markdown' ? { label: label, md: text(o.content) } : { label: label, code: text(o.content) };
    },
    update_artifact: function (o) {
      var card = o.id && document.querySelector('.artifact-card[data-artifact="' + String(o.id).replace(/[^\w-]/g, '') + '"]');
      var label = 'Rewriting ' + (o.title || (card && card.dataset.title) ? '“' + (o.title || card.dataset.title) + '”' : 'an artifact');
      return card && card.dataset.type === 'markdown' ? { label: label, md: text(o.content) } : { label: label, code: text(o.content) };
    },
    create_flashcards: function (o) {
      return { label: 'Writing flashcards' + (o.title ? ' “' + o.title + '”' : ''),
               md: list(o.cards).map(function (c) { return '- **' + text(c.front) + '**' + (c.back ? '  \n  ' + text(c.back) : ''); }).join('\n') };
    },
    create_quiz: function (o) {
      return { label: 'Writing a quiz' + (o.title ? ' “' + o.title + '”' : ''),
               md: list(o.questions).map(function (q, k) {
                 return (k + 1) + '. ' + text(q.question) + '\n' + list(q.options).map(function (x) { return '   - ' + text(x); }).join('\n');
               }).join('\n') };
    },
    propose_node_edit: function (o) {
      var parts = [];
      if (o.title) parts.push('**' + o.title + '**');
      if (o.compression) parts.push('*' + o.compression.split('\n').join('*  \n*') + '*');
      if (o.body) parts.push(o.body);
      return { label: 'Proposing an edit', md: parts.join('\n\n') };
    },
    propose_map_changes: function (o) {
      var parts = [];
      function idea(n, fallback) {
        var p = ['### ' + (n.title || n.id || fallback)];
        if (n.compression) p.push('*' + n.compression + '*');
        if (n.body) p.push(n.body);
        return p.join('\n\n');
      }
      if (list(o.groups).length) parts.push(list(o.groups).map(function (g) { return '- New group **' + text(g.id) + '**: ' + text(g.compression); }).join('\n'));
      list(o.add).forEach(function (n) { parts.push(idea(n, 'New idea')); });
      list(o.update).forEach(function (n) { parts.push(idea(n, 'Idea')); });
      if (list(o.remove).length) parts.push('Remove: ' + list(o.remove).join(', '));
      return { label: 'Proposing map changes', md: parts.join('\n\n') };
    }
  };

  function size(n) { return n < 1000 ? n + ' chars' : (n / 1000).toFixed(1) + 'k chars'; }

  // drafts(box, follow, say): BOX holds the blocks, FOLLOW keeps the log scrolled, SAY(label)
  // names what is being written (the status line's verb). Returns the handler for `draft` events.
  function drafts(box, follow, say) {
    var open = {};
    function draw(d) {
      d.timer = null;
      var o = parsePartial(d.json);
      if (!o || typeof o !== 'object') return;
      var v = views[d.tool](o);
      d.label.textContent = v.label;
      if (say && !d.done) say(v.label);
      var body = v.md !== undefined ? v.md : v.code;
      d.count.textContent = body ? size(body.length) : '';
      if (v.md !== undefined) {
        if (!d.prose) { d.prose = document.createElement('div'); d.prose.className = 'draft-body md'; d.el.appendChild(d.prose); }
        d.prose.innerHTML = window.md.render(v.md);
      } else if (body) {
        if (!d.code) { d.code = document.createElement('pre'); d.code.className = 'draft-code'; d.el.appendChild(d.code); }
        // Source is watched, not read: keep the newest lines in view.
        d.code.textContent = body; d.code.scrollTop = d.code.scrollHeight;
      }
      d.keep = v.md !== undefined;
      box.hidden = false;
      if (follow) follow();
    }
    return function (data) {
      var d = open[data.id];
      if (data.tool) {
        if (!views[data.tool] || d) return;
        d = open[data.id] = { tool: data.tool, json: '', timer: null, done: false };
        d.el = document.createElement('section'); d.el.className = 'draft writing';
        var head = document.createElement('p'); head.className = 'draft-head';
        d.label = document.createElement('span'); d.count = document.createElement('span'); d.count.className = 'draft-count';
        head.appendChild(d.label); head.appendChild(d.count); d.el.appendChild(head);
        d.label.textContent = 'Writing';
        box.appendChild(d.el); box.hidden = false;
        if (say) say('Writing');
        if (follow) follow();
      } else if (d && typeof data.partial === 'string') {
        d.json += data.partial;
        if (!d.timer) d.timer = setTimeout(function () { draw(d); }, 100);
      } else if (d && data.done) {
        if (d.timer) clearTimeout(d.timer);
        d.done = true; draw(d);
        d.el.classList.remove('writing');
        // Prose stays to be read until the reply is finished; source gives way to the thing itself.
        if (!d.keep) { d.el.remove(); if (!box.children.length) box.hidden = true; }
      }
    };
  }

  window.toolDrafts = drafts;
  window.toolDrafts.parse = parsePartial;
})();
