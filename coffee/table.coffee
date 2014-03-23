
Vue = require 'vue'
{call} = require './evaluate'
{parseShort} = require 'cirru-parser'
exports.bind = ->

  vm = new Vue
    el: '#app'
    data:
      code: localStorage.getItem('code-in-table')
    methods:
      handleKey: (event) ->
        if event.keyCode is 13
          if event.metaKey
            event.preventDefault()
            record = []
            scope = {}
            programe = parseShort @code
            call record, scope, programe
            console.log record

  vm.$watch 'code', (code) ->
    localStorage.setItem 'code-in-table', code