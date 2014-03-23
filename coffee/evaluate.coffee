
{read, run, use} = require './core'

arithmetic = require './arithmetic'
compare = require './compare'
bool = require './bool'

exports.call = (record, scope, code) ->
  
  code.unshift 'block'
  run record, scope, code

methods = {}

registry =
  get: (record, scope, args) ->
    track =
      name: ['get'].concat args
      args: ['get']
      params: []
      hidden: []
    ret = read track.params, scope, args[0]
    track.args.push ret
    track.ret = ret
    record.push track
    ret

  set: (record, scope, args) ->
    track =
      name: ['set'].concat args
      args: ['set']
      params: []
      hidden: []
    name = use track.params, scope, args[0]
    value = read track.params, scope, args[1]
    track.args.push name, value
    ret = scope[name] = value
    track.ret = ret
    record.push track
    ret

  if: (record, scope, args) ->
    track =
      name: ['if'].concat args
      args: ['if']
      params: []
      hidden: []
    cond = read track.params, scope, args[0]
    track.args.push cond
    if cond
      ret = read track.params, scope, args[1]
    else if args[2]?
      ret = read track.params, scope, args[2]
    track.ret = ret
    record.push track
    ret

  f: (record, scope, args) ->
    pattern = args[0]
    body = args[1..]
    body.unshift 'block'
    child =
      __proto__: scope

    ret = (outerRecord, outerScope, outerArgs) ->
      track =
        name: ['[f]'].concat outerArgs
        args: ['[f]']
        params: []
        hidden: []
      outerArgs.forEach (para, index) ->
        key = pattern[index]
        child[key] = read track.params, outerScope, para
        track.args.push child[key]
      result = run track.hidden, child, body
      track.ret = result
      outerRecord.push track
      result

    ret

  block: (record, scope, args) ->
    track =
      name: ['block'].concat args
      args: ['block']
      params: []
      hidden: []
    ret = undefined
    args.forEach (exp) ->
      ret = run track.params, scope, exp
      track.args.push ret

    track.ret = ret
    record.push track

    ret

  print: (record, scope, args) ->
    track =
      name: ['print'].concat args
      args: ['print']
      params: []
      hidden: []
    results = args.map (x) ->
      read track.params, scope, x
    track.args.push results...
    console.log results...

    record.push track
    undefined

  '+': arithmetic['+']
  '-': arithmetic['-']
  '*': arithmetic['*']
  '/': arithmetic['/']

  '>': compare['>']
  '<': compare['<']
  '>=': compare['>=']
  '<=': compare['<=']
  '=': compare['=']

  'and': compare['and']
  'or': compare['or']
  'not': compare['not']

exports.registry = registry