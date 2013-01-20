
define (require, exports) ->
  log = -> console?.log?.apply? console, arguments
  delay = (f, t) -> setTimeout t, f
  q = (query) -> document.querySelector query

  cirru = require("./editor")
  cirru.editor (q "#editor")

  delay 2000, ->
    ret = cirru.content()
    log ret
    # delay 2000, ->
    #   ret.push ret.concat()
    #   cirru.content ret

  exports