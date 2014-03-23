
doctype
html
  head
    title $ = Cirru Table
    meta (:charset utf-8)
    link (:rel stylesheet)
      , (:type text/css) (:href css/style.css)
    script (:type text/javascript)
      , (:src build/build.js) (:defer)
  
  @partial table.cirru
  @partial expression.cirru