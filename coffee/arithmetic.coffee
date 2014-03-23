
{read} = require './core'

module.exports =
  '+': (record, scope, args) ->
    track =
      name: ['+'].concat args
      args: ['+']
      params: []
      hidden: []
    sum = 0
    while args.length > 0
      ret = read track.params, scope, args.shift()
      track.args.push ret
      sum += ret
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
    track.args.push left
    while args.length > 0
      ret = read track.params, scope, args.shift()
      track.args.push ret
      left -= ret
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
    while args.length > 0
      ret = read track.params, scope, args.shift()
      track.args.push ret
      product *= ret
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
    while args.length > 0
      ret = read track.params, scope, args.shift()
      track.args.push ret
      division /= ret

    track.ret = division
    record.push track
    division