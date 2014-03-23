
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
    left = read record, scope, args.shift()
    do sub = ->
      if args.length > 0
        ret = read record, scope, args.shift()
        left -= ret
        sub()
    left

  '*': (record, scope, args) ->
    product = read record, scope, args.shift()
    do mutiply = ->
      if args.length > 0
        ret = read record, scope, args.shift()
        product *= ret
        mutiply()
    product

  '/': (record, scope, args) ->
    division = read record, scope, args.shift()
    do divide = ->
      if args.length > 0
        ret = read record, scope, args.shift()
        division /= ret
        divide()
    division