
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
    read record, scope, args[0]

  set: (record, scope, args) ->
    name = use record, scope, args[0]
    value = read record, scope, args[1]
    scope[name] = value

  if: (record, scope, args) ->
    cond = read record, scope, args[0]
    if cond
      read record, scope, args[1]
    else if args[2]?
      read record, scope, args[2]

  f: (record, scope, args) ->
    pattern = args[0]
    body = args[1..]
    body.unshift 'block'
    child =
      parent: scope

    (outerRecord, outerScope, outerArgs) ->
      outerArgs.forEach (para, index) ->
        key = pattern[index]
        child[key] = read outerArgs, outerScope, para
      run outerRecord, child, body

  block: (record, scope, args) ->
    ret = undefined
    args.forEach (exp) ->
      ret = run record, scope, exp
    ret

  print: (record, scope, args) ->
    results = args.map (x) ->
      read record, scope, x
    console.log results...
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