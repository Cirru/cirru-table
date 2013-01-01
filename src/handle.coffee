
define (require, exports) ->
  log = -> console?.log?.apply? console, arguments
  delay = (f, t) -> setTimeout t, f
  q = (query) -> document.querySelector query

  cirru = require("./editor")
  cirru.editor (q "#editor")

  delay 4000, ->
    log cirru.content()

  exports