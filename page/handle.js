// Generated by CoffeeScript 1.4.0

define(function(require, exports) {
  var cirru, delay, log, q;
  log = function() {
    var _ref;
    return typeof console !== "undefined" && console !== null ? (_ref = console.log) != null ? typeof _ref.apply === "function" ? _ref.apply(console, arguments) : void 0 : void 0 : void 0;
  };
  delay = function(f, t) {
    return setTimeout(t, f);
  };
  q = function(query) {
    return document.querySelector(query);
  };
  cirru = require("./editor");
  cirru.editor(q("#editor"));
  delay(2000, function() {
    var ret;
    ret = cirru.content();
    log(ret);
    return delay(2000, function() {
      ret.push(ret.concat());
      return cirru.content(ret);
    });
  });
  return exports;
});
