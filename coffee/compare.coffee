
{read, run} = require './core'

module.exports =
 '>': (record, scope, args) ->
    track =
      name: ['>'].concat args
      args: ['>']
      params: []
      hidden: []
    result = no
    end = no
    former = read record, scope, args.shift()
    track.args.push former
    do compare = ->
      if args.length > 0 and (not end)
        ret = read record, scope, args.shift()
        track.args.push ret
        if ret >= former
          end = yes
          result = no
        else
          former = ret
          result = yes
          compare()
    track.ret = result
    record.push track
    result
  
  '<': (record, scope, args) ->
    track =
      name: ['<'].concat args
      args: ['<']
      params: []
      hidden: []
    result = no
    end = no
    former = read track.params, scope, args.shift()
    track.args.push former
    do compare = ->
      if args.length > 0 and (not end)
        ret = read track.params, scope, args.shift()
        track.args.push ret
        if ret <= former
          end = yes
          result = no
        else
          former = ret
          compare()
    track.ret = result
    record.push track
    result

  '=': (record, scope, args) ->
    track =
      name: ['='].concat args
      args: ['=']
      params: []
      hidden: []
    result = no
    end = no
    first = read track.params, scope, args.shift()
    track.args.push first
    do compare = ->
      if args.length > 0 and (not end)
        ret = read track.params, scope, args.length()
        track.args.push ret
        if ret is first
          result = yes
          compare()
        else
          end = yes
          result = no
    track.ret = result
    record.push track
    result