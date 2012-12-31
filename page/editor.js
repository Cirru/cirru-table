// Generated by CoffeeScript 1.4.0

define(function(require, exports) {
  var curr_tag, input, jump, log, ls, shortcut, tag_code, tag_pre, utils;
  log = function() {
    return console.log.apply(console, arguments);
  };
  input = document.createElement("input");
  curr_tag = {};
  ls = localStorage;
  shortcut = {};
  jump = function(next) {
    var code, last, selection;
    last = curr_tag;
    selection = last.querySelector(".selection");
    log("selection", selection);
    if (selection != null) {
      last.removeChild(selection);
    }
    if (next.tagName.toLowerCase() === "code") {
      input.value = next.textContent;
      curr_tag = next;
    } else {
      input.value = "";
      code = tag_code();
      next.appendChild(code);
      curr_tag = code;
    }
    if (last.textContent === "") {
      last.parentNode.removeChild(last);
    }
    if (input.onkeyup != null) {
      input.onkeyup();
    }
    return input.focus();
  };
  tag_code = function() {
    var code;
    code = document.createElement("code");
    code.onclick = function(click) {
      jump(code);
      click.cancelBubble = true;
      return click.returnValue = false;
    };
    return code;
  };
  tag_pre = function() {
    var pre;
    pre = document.createElement("pre");
    pre.onclick = function(click) {
      jump(pre);
      click.cancelBubble = true;
      return click.returnValue = false;
    };
    return pre;
  };
  utils = require("./utils");
  utils.insertAfter();
  exports.editor = function(elem) {
    var all, code, editor, pre, update, _fn, _fn1, _i, _j, _len, _len1;
    editor = elem.querySelector(".cirru-editor");
    elem.appendChild(input);
    try {
      editor.innerHTML = utils.render(JSON.parse(ls.list));
      log(editor.innerHTML);
      all = editor.querySelectorAll("code");
      curr_tag = all[all.length - 1];
      input.value = curr_tag.textContent;
      input.focus();
      _fn = function(code) {
        return code.onclick = function(click) {
          jump(code);
          click.returnValue = false;
          return click.cancelBubble = true;
        };
      };
      for (_i = 0, _len = all.length; _i < _len; _i++) {
        code = all[_i];
        _fn(code);
      }
      all = editor.querySelectorAll("pre");
      _fn1 = function(pre) {
        return pre.onclick = function(click) {
          log("jump to pre");
          jump(pre);
          click.returnValue = false;
          return click.cancelBubble = true;
        };
      };
      for (_j = 0, _len1 = all.length; _j < _len1; _j++) {
        pre = all[_j];
        _fn1(pre);
      }
    } catch (error) {
      log("fallback:", error);
      curr_tag = tag_code();
      editor.appendChild(curr_tag);
    }
    update = function() {
      var left, top;
      curr_tag.innerHTML = utils.input(input);
      left = curr_tag.querySelector(".selection").offsetLeft;
      curr_tag.scrollLeft = left - 100;
      ls.list = JSON.stringify((utils.read(editor))[0]);
      curr_tag.offsetParent = editor;
      top = curr_tag.offsetTop;
      left = curr_tag.offsetLeft;
      input.style.top = "" + top + "px";
      return input.style.left = "" + left + "px";
    };
    input.onkeypress = update;
    input.onkeyup = update;
    elem.onclick = function(click) {
      code = tag_code();
      editor.appendChild(code);
      jump(code);
      click.returnValue = false;
      return input.focus();
    };
    return input.onkeydown = function(down) {
      var _ref;
      log(down.keyCode);
      if ((_ref = down.keyCode) === 9 || _ref === 13 || _ref === 32) {
        down.returnValue = false;
      }
      switch (down.keyCode) {
        case 9:
          return utils.tab(input);
        case 32:
          code = tag_code();
          curr_tag.insertAfter(code);
          return jump(code);
        case 13:
          pre = tag_pre();
          curr_tag.insertAfter(pre);
          code = tag_code();
          pre.appendChild(code);
          return jump(code);
        case 8:
          if (input.selectionEnd === 0) {
            shortcut["delete"]();
            return down.returnValue = false;
          }
      }
    };
  };
  shortcut["delete"] = function() {
    var last, place, prev;
    prev = curr_tag.previousElementSibling;
    if (prev != null) {
      return prev.click();
    } else {
      last = curr_tag.parentNode;
      if (last.className.trim() !== "cirru-editor") {
        place = last.parentNode;
        place.removeChild(last);
        return place.click();
      }
    }
  };
  return exports;
});
