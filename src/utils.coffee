
define (require, exports) ->
  log = -> console.log.apply console, arguments

  exports.escape = escape = (str) ->
    str.replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/\s/g, "<span class='space'>&nbsp;</span>")

  exports.unescape = (str) ->
    div = document.createElement "div"
    div.innerHTML = str
    div.innerText

  exports.input = (input) ->
    log input
    text = input.value
    start = input.selectionStart
    end = input.selectionEnd
    s1 = escape text[0...start]
    p2 = escape text[start...end]
    s2 = "<span class='selection'>#{p2}</span>"
    s3 = escape text[end...]
    "#{s1}#{s2}#{s3}"

  exports.tab = (input, down) ->
    log input
    start = input.selectionStart
    end = input.selectionEnd
    text = input.value
    input.value = text[...start] + " " + text[end..]
    input.selectionStart = start + 1
    input.selectionEnd = start + 1
    input.onkeyup()
    down.returnValue = off

  exports