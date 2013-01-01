// Generated by CoffeeScript 1.4.0

define(function(require, exports) {
  var escape, log, read, render;
  log = function() {
    return console.log.apply(console, arguments);
  };
  exports.escape = escape = function(str) {
    return str.toString().replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\s/g, "<span class='space'>&nbsp;</span>");
  };
  exports.unescape = function(str) {
    var div;
    div = document.createElement("div");
    div.innerHTML = str;
    return div.innerText;
  };
  exports.input = function(input) {
    var end, p2, s1, s2, s3, start, text;
    text = input.value;
    start = input.selectionStart;
    end = input.selectionEnd;
    s1 = escape(text.slice(0, start));
    p2 = escape(text.slice(start, end));
    s2 = "<span class='selection'>" + p2 + "</span>";
    s3 = escape(text.slice(end));
    return "" + s1 + s2 + s3;
  };
  exports.tab = function(input) {
    var end, start, text;
    log(input);
    start = input.selectionStart;
    end = input.selectionEnd;
    text = input.value;
    input.value = text.slice(0, start) + " " + text.slice(end);
    input.selectionStart = start + 1;
    input.selectionEnd = start + 1;
    return input.onkeyup();
  };
  exports.after = function() {
    var after;
    after = function(elem2) {
      var next, parent;
      parent = this.parentNode;
      next = this.nextElementSibling;
      log("after:", parent, next);
      if (next != null) {
        return parent.insertBefore(elem2, next);
      } else {
        return parent.appendChild(elem2);
      }
    };
    return Node.prototype.after = after;
  };
  exports.read = window.read = read = function(elem) {
    if (elem.tagName.toLowerCase() === "code") {
      return elem.textContent;
    } else {
      return Array.prototype.map.call(elem.childNodes, read);
    }
  };
  render = function(list) {
    var _ref;
    if (Array.isArray(list)) {
      return "<pre>" + (list.map(render).join("")) + "</pre>";
    } else if ((_ref = typeof list) === "string" || _ref === "number") {
      return "<code>" + (escape(list)) + "</code>";
    }
  };
  exports.render = function(list) {
    var html;
    log("render:", list);
    html = render(list);
    return html.slice(5, -6);
  };
  return exports;
});
