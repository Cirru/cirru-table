
Vue = require 'vue'
{call} = require './evaluate'
{parseShort} = require 'cirru-parser'

exports.bind = ->

  vm = new Vue
    el: '#app'
    data:
      code: 'set a 1'
    methods:
      handleKey: (event) ->
        if event.keyCode is 13
          if event.metaKey
            event.preventDefault()
            console.log 'evaluate'
            record = []
            scope = {}
            programe = parseShort @code
            call record, scope, programe
            console.log record, scope