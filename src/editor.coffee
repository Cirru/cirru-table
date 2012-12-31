
define (require, exports) ->

  log = -> console.log.apply console, arguments
  input = document.createElement "input"
  curr_tag = {}

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

  tag_code = ->
    code = document.createElement "code"
    code.onclick = ->
      jump code
    code

  tag_pre = -> document.createElement "pre"

  utils = require "./utils"

  exports.editor = (elem) ->
    editor = elem.querySelector ".cirru-editor"
    curr_tag = tag_code()
    elem.appendChild input
    editor.appendChild curr_tag

    update = ->
      curr_tag.innerHTML = utils.input input
      left = curr_tag.querySelector(".selection").offsetLeft
      curr_tag.scrollLeft = left - 100
    input.onkeypress = update
    input.onkeyup = update

    elem.onclick = (click) ->
      input.focus()
      click.returnValue = no

    input.onkeydown = (down) ->
      log down.keyCode
      switch down.keyCode
        when 9 then utils.tab input, down
        when 32
          down.returnValue = off
          parent = curr_tag.parentNode
          new_tag = tag_code()
          next = new_tag.nextElementSibling
          if next?
            parent.insertBefore new_tag, next
          else
            parent.appendChild new_tag
          jump new_tag

  exports