
define (require, exports) ->

  log = -> console.log.apply console, arguments
  input = document.createElement "input"
  curr_tag = {}
  ls = localStorage
  shortcut = {}

  jump = (next) ->
    parent = curr_tag.parentNode
    last = curr_tag
    
    selection = last.querySelector(".selection")
    # log "selection", selection
    if selection? then last.removeChild selection
    if next.tagName.toLowerCase() is "code"
      input.value = next.textContent
      curr_tag = next
    else
      input.value = ""
      code = tag_code()
      next.appendChild code
      curr_tag = code

    if last.textContent is ""
      last.parentNode.removeChild last

    parent.onleave?()
    input.onkeyup?()
    input.focus()

  tag_code = ->
    code = document.createElement "code"
    code.onclick = (click) ->
      jump code
      click.cancelBubble = yes
      click.returnValue = off
    code

  onleave = (pre) ->
    pre.onleave = ->
      # log "onleave", pre.childNodes
      if pre.childNodes.length is 0
        parent = pre.parentNode
        try
          parent.removeChild pre
          parent.onleave?()
        catch error
          log "already removed:", error

  tag_pre = ->
    pre = document.createElement "pre"
    pre.onclick = (click) ->
      jump pre
      click.cancelBubble = yes
      click.returnValue = off
    onleave pre
    pre

  utils = require "./utils"
  utils.after()

  load = (elem, editor, list) ->
    try
      editor.innerHTML = utils.render list
      Array.prototype.map.call editor.childNodes, fold
      # log editor.innerHTML
      all = editor.querySelectorAll("code")
      curr_tag = all[all.length-1]
      input.value = curr_tag.textContent
      input.focus()

      for code in all
        do (code) ->
          code.onclick = (click) ->
            jump code
            click.returnValue = off
            click.cancelBubble = yes
      all = editor.querySelectorAll("pre")
      for pre in all
        do (pre) ->
          pre.onclick = (click) ->
            # log "jump to pre"
            jump pre
            click.returnValue = off
            click.cancelBubble = yes
          onleave pre

      editor.click()
    catch error
      log "fallback:", error
      curr_tag = tag_code()
      editor.innerHTML = ""
      editor.appendChild curr_tag

  fold = (pre) ->
    # log pre
    if pre.tagName.toLowerCase() is "pre"
      pre.className = "fold"
      if pre.parentNode.className is "fold"
        pre.parentNode.className = ""
      if pre.childNodes.length < 5
        Array.prototype.map.call pre.childNodes, fold
      else
        pre.className = ''

  exports.editor = (elem) ->
    editor = elem.querySelector ".cirru-editor"
    elem.appendChild input

    try
      his = JSON.parse ls.list
    catch err
      his = {}
    load elem, editor, his

    update = ->
      curr_tag.innerHTML = utils.input input
      left = curr_tag.querySelector(".selection").offsetLeft
      curr_tag.scrollLeft = left - 100
      ls.list = JSON.stringify (utils.read editor)

      curr_tag.offsetParent = editor
      top = curr_tag.offsetTop
      left = curr_tag.offsetLeft
      input.style.top = "#{top}px"
      input.style.left = "#{left}px"

      Array.prototype.map.call editor.childNodes, fold

      start = elem.scrollTop
      height = elem.offsetHeight
      if top < start
        elem.scrollTop = top - (height / 2)
      else if top > (height + start)
        elem.scrollTop = top + (height / 2)

    input.onkeypress = update
    input.onkeyup = update

    elem.onclick = (click) ->
      code = tag_code()
      editor.appendChild code
      jump code
      click.returnValue = no
      input.focus()

    input.onkeydown = (down) ->
      log down.keyCode
      if down.keyCode in [9,13,32,33,34] then down.returnValue = off
      switch down.keyCode
        when 9 then utils.tab input
        when 32 # then spacebar
          code = tag_code()
          curr_tag.after code
          jump code
        when 13 # enter key
          pre = tag_pre()
          curr_tag.after pre
          code = tag_code()
          pre.appendChild code
          jump code
        when 8 # backspace
          if input.selectionEnd is 0
            shortcut.delete()
            down.returnValue = off
        when 37 # left
          if input.selectionEnd is 0
            shortcut.left()
            down.returnValue = off
        when 39 # right
          log input.selectionStart, input.value.length
          if input.selectionStart is input.value.length
            shortcut.right()
            down.returnValue = off
        when 38 then shortcut.up()
        when 40 then shortcut.down()
        when 33 then shortcut.pgup()
        when 34 then shortcut.pgdown()

    shortcut.delete = ->
      prev = curr_tag.previousElementSibling
      if prev?
        prev.click()
      else
        parent = curr_tag.parentNode
        unless parent.className is "cirru-editor"
          place = parent.parentNode
          place.removeChild parent
          place.click()
          place.onleave?()

    shortcut.left = ->
      prev = curr_tag.previousElementSibling
      if prev?
        prev.click()
      else
        parent = curr_tag.parentNode
        unless parent.className is "cirru-editor"
          code = tag_code()
          if curr_tag.textContent is ""
            place = parent.parentNode
            place.insertBefore code, parent
          else
            parent.insertBefore code, curr_tag
          code.click()

    shortcut.right = ->
      next = curr_tag.nextElementSibling
      if next?
        if next.tagName.toLowerCase() is "code"
          next.click()
        else
          code = tag_code()
          next.insertAdjacentElement "afterbegin", code
          code.click()
      else
        parent = curr_tag.parentNode
        log "this parent", parent
        unless parent.className is "cirru-editor"
          log "follows", parent
          code = tag_code()
          if curr_tag.textContent is ""
            parent.after code
          else
            parent.appendChild code
          code.click()

    shortcut.up = ->
      prev = curr_tag.previousElementSibling
      while prev? and prev.tagName.toLowerCase() is "code"
        prev = prev.previousElementSibling
      if prev?
        prev.click()
      else
        parent = curr_tag.parentNode
        unless parent.className is "cirru-editor"
          place = parent.parentNode
          code = tag_code()
          place.insertBefore code, parent
          code.click()

    shortcut.down = ->
      next = curr_tag.nextElementSibling
      while next? and next.tagName.toLowerCase() is "code"
        next = next.nextElementSibling
      if next?
        code = tag_code()
        next.insertAdjacentElement "afterbegin", code
        code.click()
      else
        parent = curr_tag.parentNode
        log "down", parent
        unless parent.className is "cirru-editor"
          code = tag_code()
          parent.after code
          code.click()

    shortcut.pgup = ->
      parent = curr_tag
      until parent.parentNode.className is "cirru-editor"
        parent = parent.parentNode
        log parent
      prev = parent.previousElementSibling
      while prev?.previousElementSibling?.tagName.toLowerCase() is "code"
        prev = prev.previousElementSibling
      if prev?
        prev.click()
      else
        pre = tag_pre()
        code = tag_code()
        editor.insertAdjacentElement "afterbegin", pre
        log "editor", editor
        pre.appendChild code
        code.click()

    shortcut.pgdown = ->
      parent = curr_tag
      until parent.parentNode.className is "cirru-editor"
        parent = parent.parentNode
        log parent
      next = parent.nextElementSibling
      while next?.nextElementSibling?.tagName.toLowerCase() is "code"
        next = next.nextElementSibling
      if next?
        next.click()
      else
        pre = tag_pre()
        code = tag_code()
        editor.appendChild pre
        log "editor", editor
        pre.appendChild code
        code.click()

    exports.content = (list) ->
      if list?
        load elem, editor, list
      else
        editor.click()
        list = utils.read editor
        list.pop()
        list

    exports.focus = -> editor.focus()

  exports