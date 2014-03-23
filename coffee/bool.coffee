
{read, run} = require './core'

module.exports =  
 
  and: (record, scope, args) ->
    track =
      name: 'and'
      args: args
      params: []
      hidden: []
    ret = read track.params, scope, args.shift()
    do andExpression = ->
      if args.length > 0
        comming = read track.params, scope, args.shift()
        ret = ret and comming
        if ret
          andExpression()
    track.ret = ret
    record.push track
    ret

  or: (record, scope, args) ->
    track =
      name: 'or'
      args: args
      params: []
      hidden: []
    ret = read track.params, scope, args.shift()
    do orExpression = ->
      if args.length > 0
        comming = read track.params, scope, args.shift()
        ret = ret or comming
        unless ret
          orExpression()
    track.ret = ret
    record.push track
    ret

  not: (record, scope, args) ->
    track =
      name: 'not'
      args: args
      params: []
      hidden: []
    origin = read track.params, scope, args.shift()
    track.ret = ret
    record.push track
    not origin

