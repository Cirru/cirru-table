
tool = require './util'
{q} = tool

{parseShort} = require 'cirru-parser'

q('#editor').onkeydown = (event) ->
  if event.keyCode is 13 and event.metaKey
    console.log (parseShort @value)