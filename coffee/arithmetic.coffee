
{read} = require './core'

module.exports =
  '+': (record, scope, args) ->
    track =
      name: ['+'].concat args
      args: ['+']
      params: []
      hidden: []
    sum = 0
    do add = ->
      if args.length > 0
        ret = read track.params, scope, args.shift()
        track.args.push ret
        sum += ret
        add()
    track.ret = sum
    record.push track
    sum

  '-': (record, scope, args) ->
    track =
      name: ['-'].concat args
      args: ['-']
      params: []
      hidden: []

    left = read track.params, scope, args.shift()
    console.log 'got left', left
    track.args.push left
    do sub = ->
      if args.length > 0
        ret = read track.params, scope, args.shift()
        track.args.push ret
        left -= ret
        sub()
    track.ret = left
    record.push track
    left

  '*': (record, scope, args) ->
    track =
      name: ['*'].concat args
      args: ['*']
      params: []
      hidden: []
    product = read track.params, scope, args.shift()
    track.args.push product
    do mutiply = ->
      if args.length > 0
        ret = read track.params, scope, args.shift()
        track.args.push ret
        product *= ret
        mutiply()
    track.ret = product
    record.push track
    product

  '/': (record, scope, args) ->
    track =
      name: ['/'].concat args
      args: ['/']
      params: []
      hidden: []
    division = read track.params, scope, args.shift()
    track.args.push division
    do divide = ->
      if args.length > 0
        ret = read track.params, scope, args.shift()
        track.args.push ret
        division /= ret
        divide()

    track.ret = division
    record.push track
    division