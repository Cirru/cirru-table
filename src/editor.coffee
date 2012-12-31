
define (require, exports) ->

  log = -> console.log.apply console, arguments
  input = document.createElement "input"
  curr_tag = {}
  ls = localStorage

  jump = (next) ->
    last = curr_tag
    curr_tag = next
    
    selection = last.querySelector(".selection")
    log "selection", selection
    if selection?
      last.removeChild selection
    input.value = next.textContent

    if last.textContent is ""
      last.parentNode.removeChild last

    input.onkeyup()
    last

  tag_code = ->
    code = document.createElement "code"
    code.onclick = ->
      jump code
    code

  tag_pre = -> document.createElement "pre"

  utils = require "./utils"
  utils.insertAfter()

  exports.editor = (elem) ->
    editor = elem.querySelector ".cirru-editor"
    elem.appendChild input
    if ls.innerHTML?
      editor.innerHTML = ls.innerHTML
      selection = editor.querySelector ".selection"
      curr_tag = selection.parentNode
      input.value = curr_tag.textContent
    else
      curr_tag = tag_code()
      editor.appendChild curr_tag

    update = ->
      curr_tag.innerHTML = utils.input input
      left = curr_tag.querySelector(".selection").offsetLeft
      curr_tag.scrollLeft = left - 100
      ls.innerHTML = editor.innerHTML

    input.onkeypress = update
    input.onkeyup = update

    elem.onclick = (click) ->
      input.focus()
      click.returnValue = no

    input.onkeydown = (down) ->
      log down.keyCode
      if down.keyCode in [9,13,32] then down.returnValue = off
      switch down.keyCode
        when 9 then utils.tab input
        when 32
          code = tag_code()
          curr_tag.insertAfter code
          jump code
        when 13
          pre = tag_pre()
          curr_tag.insertAfter pre
          code = tag_code()
          pre.appendChild code
          jump code

  exports