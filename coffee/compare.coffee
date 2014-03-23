
{read, run} = require './core'

module.exports =
 '>': (record, scope, args) ->
    result = no
    end = no
    former = read record, scope, args.shift()
    do compare = ->
      if args.length > 0 and (not end)
        ret = read record, scope, args.shift()
        if ret >= former
          end = yes
          result = no
        else
          compare()
    result
  
  '<': (record, scope, args) ->
    result = no
    end = no
    former = read record, scope, args.shift()
    do compare = ->
      if args.length > 0 and (not end)
        ret = read record, scope, args.shift()
        if ret <= former
          end = yes
          result = no
        else
          compare()
    result

  '>=': (record, scope, args) ->

  '<=': (record, scope, args) ->

  '=': (record, scope, args) ->
    result = ''
