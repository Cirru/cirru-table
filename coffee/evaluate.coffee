
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
      name: 'get'
      args: args
      params: []
      hidden: []
    ret = read track.params, scope, args[0]
    track.ret = ret
    record.push track
    ret

  set: (record, scope, args) ->
    track =
      name: 'set'
      args: args
      params: []
      hidden: []
    name = use track.params, scope, args[0]
    value = read track.params, scope, args[1]
    ret = scope[name] = value
    track.ret = ret
    record.push track
    ret

  if: (record, scope, args) ->
    track =
      name: 'if'
      args: args
      params: []
      hidden: []
    cond = read track.params, scope, args[0]
    if cond
      ret = read track.params, scope, args[1]
    else if args[2]?
      ret = read record, scope, args[2]
    track.ret = ret
    record.push track
    ret

  f: (record, scope, args) ->
    track =
      name: 'f'
      args: args
      params: []
      hidden: []
    pattern = args[0]
    body = args[1..]
    body.unshift 'block'
    child =
      parent: scope

    ret = (outerRecord, outerScope, outerArgs) ->
      outerArgs.forEach (para, index) ->
        key = pattern[index]
        child[key] = read track.params, outerScope, para
      run track.hidden, child, body

    track.ret = ret
    record.push track

    ret

  block: (record, scope, args) ->
    track =
      name: 'block'
      args: args
      params: []
      hidden: []
    ret = undefined
    args.forEach (exp) ->
      ret = run record, scope, exp

    track.ret = ret
    record.push ret

    ret

  print: (record, scope, args) ->
    track =
      name: 'print'
      args: args
      params: []
      hidden: []
    results = args.map (x) ->
      read track.params, scope, x
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