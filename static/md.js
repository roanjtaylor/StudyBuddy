// Markdown → HTML in the browser, for a reply while it streams. The same subset as
// markdown->html in src/html.lisp (which renders the reply once it is stored):
// paragraphs, # to #### headings, - and 1. lists nested by indent, ``` fences,
// > quotes, | tables |, ---, **bold**, *em*, `code`, ~~struck~~, [links](url).
// Everything is escaped first; model output never becomes markup.
window.md = (function () {
  function escape(s) {
    return s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
  }
  // Unpaired delimiters stay as written.
  function pairs(s, delim, open, close) {
    var out = '', start = 0;
    for (;;) {
      var a = s.indexOf(delim, start);
      var b = a < 0 ? -1 : s.indexOf(delim, a + delim.length);
      if (b < 0) return out + s.slice(start);
      out += s.slice(start, a) + open + s.slice(a + delim.length, b) + close;
      start = b + delim.length;
    }
  }
  function links(s) {
    return s.replace(/\[([^\]]+)\]\(((?:https?:\/\/|\/)[^)\s]+)\)/g,
      '<a href="$2" target="_blank" rel="noopener">$1</a>');
  }
  function inline(s) {
    var e = escape(s);
    e = pairs(e, '`', '<code>', '</code>');
    e = pairs(e, '**', '<strong>', '</strong>');
    e = pairs(e, '~~', '<s>', '</s>');
    e = pairs(e, '*', '<em>', '</em>');
    return links(e);
  }
  function cells(line) {
    var t = line.trim();
    if (t.length < 2 || t[0] !== '|') return null;
    return t.replace(/^\|/, '').replace(/\|$/, '').split('|').map(function (c) { return c.trim(); });
  }
  function ruleRow(line) {
    var c = cells(line);
    return c && c.every(function (x) { return x.length > 0 && /^[-: ]+$/.test(x); });
  }

  function render(text) {
    var out = '', para = [], lists = [], fence = null, code = [], quote = [], table = [];
    function endPara() { if (para.length) { out += '<p>' + inline(para.join(' ')) + '</p>\n'; para = []; } }
    function closeLists(to) { while (lists.length > to) out += '</li></' + lists.pop() + '>\n'; }
    function item(tag, t, depth) {
      if (lists.length > depth + 1) { closeLists(depth + 1); out += '</li><li>' + inline(t); }
      else if (lists.length === depth + 1) {
        if (lists[lists.length - 1] === tag) out += '</li><li>' + inline(t);
        else { closeLists(depth); lists.push(tag); out += '<' + tag + '><li>' + inline(t); }
      } else {
        while (lists.length < depth) { lists.push('ul'); out += '<ul><li>'; }
        lists.push(tag); out += '<' + tag + '><li>' + inline(t);
      }
    }
    function endQuote() { if (quote.length) { out += '<blockquote>' + render(quote.join('\n')) + '</blockquote>\n'; quote = []; } }
    function endTable() {
      if (!table.length) return;
      out += '<table><thead><tr>' + table[0].map(function (c) { return '<th>' + inline(c) + '</th>'; }).join('') + '</tr></thead><tbody>';
      for (var i = 1; i < table.length; i++) out += '<tr>' + table[i].map(function (c) { return '<td>' + inline(c) + '</td>'; }).join('') + '</tr>';
      out += '</tbody></table>\n'; table = [];
    }
    function endFence() {
      out += '<pre' + (fence ? ' class="lang-' + escape(fence) + '"' : '') + '><code>' + escape(code.join('\n')) + '</code></pre>\n';
      code = []; fence = null;
    }
    function endBlocks() { endPara(); closeLists(0); endQuote(); endTable(); }

    var lines = (text || '').split(/\r?\n/);
    for (var i = 0; i < lines.length; i++) {
      var line = lines[i], t = line.trim();
      if (fence !== null) { if (t.indexOf('```') === 0) endFence(); else code.push(line); continue; }
      var depth = Math.floor((line.match(/^ */) || [''])[0].length / 2), m;
      var isQuote = t.indexOf('> ') === 0 || t === '>', isRow = !!cells(t);
      if (!isQuote) endQuote();
      if (!isRow) endTable();
      if (t === '') { endPara(); closeLists(0); }
      else if (t.indexOf('```') === 0) { endBlocks(); fence = t.slice(3).trim(); }
      else if ((m = t.match(/^(#{1,4}) (.*)$/))) { endBlocks(); var h = m[1].length + 1; out += '<h' + h + '>' + inline(m[2]) + '</h' + h + '>\n'; }
      else if (t.length >= 3 && /^[-*_]+$/.test(t)) { endBlocks(); out += '<hr>\n'; }
      else if (isQuote) { endPara(); closeLists(0); quote.push(t === '>' ? '' : t.slice(2)); }
      else if (isRow) { endPara(); closeLists(0); if (!ruleRow(t)) table.push(cells(t)); }
      else if ((m = t.match(/^[-*] (.*)$/))) { endPara(); item('ul', m[1], depth); }
      else if ((m = t.match(/^\d+\. (.*)$/))) { endPara(); item('ol', m[1], depth); }
      else if (lists.length) out += ' ' + inline(t);
      else para.push(t);
    }
    if (fence !== null) endFence();
    endBlocks();
    return out;
  }
  return { render: render, escape: escape };
})();
