
{read, run} = require './core'

module.exports =  
 
  and: (record, scope, args) ->
    ret = read record, scope, args.shift()
    do andExpression = ->
      if args.length > 0
        comming = read record, scope, args.shift()
        ret = ret and comming
        if ret
          andExpression()
    ret

  or: (record, scope, args) ->
    ret = read record, scope, args.shift()
    do orExpression = ->
      if args.length > 0
        comming = read record, scope, args.shift()
        ret = ret or comming
        unless ret
          orExpression()
    ret

  not: (record, scope, args) ->
    origin = read record, scope, args.shift()
    not origin

