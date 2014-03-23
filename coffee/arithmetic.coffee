
{read} = require './core'

module.exports =
  '+': (record, scope, args) ->
    sum = 0
    do add = ->
      if args.length > 0
        ret = read record, scope, args.shift()
        sum += ret
        add()
    sum

  '-': (record, scope, args) ->
    left = run record, scope, args.shift()
    do sub = ->
      if args.length > 0
        ret = read record, scope, args.shift()
        left -= ret
        sub()
    left