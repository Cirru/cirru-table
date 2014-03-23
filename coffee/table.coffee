
Vue = require 'vue'
{call} = require './evaluate'
{parseShort} = require 'cirru-parser'
{generate} = require 'cirru-writer'

{Scope} = require './scope'

Vue.component 'expression',
  template: '#expression'
  data:
    extracted: yes

vm = new Vue
  el: '#app'
  data:
    code: localStorage.getItem('code-in-table')
    record: []
  methods:
    handleKey: (event) ->
      if event.keyCode is 13
        if event.metaKey
          event.preventDefault()
          @record = []
          scope = new Scope
          programe = parseShort @code
          call @record, scope, programe
    shortenRet: (ret) ->
      if typeof ret is 'function'
        '[Function]'
      else
        ret
    pretty: (code) ->
      if code?
        generate [[code]]
      else
        '--'
    joinItems: (list) ->
      list?.map (x) ->
        if typeof x is 'function' then '[f]'
        else String x
      .join ' '

vm.$watch 'code', (code) ->
  localStorage.setItem 'code-in-table', code