
define (require, exports) ->
  log = -> console?.log?.apply? console, arguments
  delay = (f, t) -> setTimeout t, f
  q = (query) -> document.querySelector query

  require("./editor").editor (q "#editor")

  exports