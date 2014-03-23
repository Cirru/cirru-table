
{read} = require './core'

module.exports =
  '+': (record, scope, args) ->
    track =
      name: '+'
      args: args
      params: []
      hidden: []
    sum = 0
    do add = ->
      if args.length > 0
        ret = read track.params, scope, args.shift()
        sum += ret
        add()
    track.ret = sum
    record.push track
    sum

  '-': (record, scope, args) ->
    track =
      name: '-'
      args: args
      params: []
      hidden: []

    left = read track.params, scope, args.shift()
    do sub = ->
      if args.length > 0
        ret = read track.params, scope, args.shift()
        left -= ret
        sub()
    track.ret = left
    record.push track
    left

  '*': (record, scope, args) ->
    track =
      name: '*'
      args: args
      params: []
      hidden: []
    product = read track.params, scope, args.shift()
    do mutiply = ->
      if args.length > 0
        ret = read track.params, scope, args.shift()
        product *= ret
        mutiply()
    track.ret = product
    record.push track
    product

  '/': (record, scope, args) ->
    track =
      name: '/'
      args: args
      params: []
      hidden: []
    division = read track.params, scope, args.shift()
    do divide = ->
      if args.length > 0
        ret = read track.params, scope, args.shift()
        division /= ret
        divide()

    track.ret = division
    record.push track
    division