
{read, run} = require './core'

module.exports =  
 
  and: (record, scope, args) ->
    track =
      name: ['and'].concat args
      args: ['and']
      params: []
      hidden: []
    ret = read track.params, scope, args.shift()
    args.push ret
    do andExpression = ->
      if args.length > 0
        comming = read track.params, scope, args.shift()
        args.push comming
        ret = ret and comming
        if ret
          andExpression()
    track.ret = ret
    record.push track
    ret

  or: (record, scope, args) ->
    track =
      name: ['or'].concat args
      args: ['or']
      params: []
      hidden: []
    ret = read track.params, scope, args.shift()
    track.args.push ret
    do orExpression = ->
      if args.length > 0
        comming = read track.params, scope, args.shift()
        track.args.push comming
        ret = ret or comming
        unless ret
          orExpression()
    track.ret = ret
    record.push track
    ret

  not: (record, scope, args) ->
    track =
      name: ['not'].concat args
      args: ['not']
      params: []
      hidden: []
    origin = read track.params, scope, args.shift()
    track.args.push origin
    track.ret = ret
    record.push track
    not origin
