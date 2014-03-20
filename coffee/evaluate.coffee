
exports.call = (record, scope, code) ->
  
  code.unshift 'block'
  run record, scope, code

run = (record, scope, exp) ->
  func = exp[0]
  args = exp[1..]
  if typeof func is 'string'
    if registry[func]?
      registry[func] record, scope, args
    else if scope[func]?
      scope[func] record, scope, args
  else
    solution = read record, scope, func
    if typeof solution is 'function'
      solution record, scope, args
    else
      throw new Error

read = (record, scope, exp) ->
  if typeof exp is 'string'
    scope[exp]
  else
    run record, scope, exp

use = (record, scope, exp) ->
  if typeof exp is 'string'
    exp
  else
    run record, scope, exp

methods = {}

registry =
  get: (record, scope, args) ->
    read record, scope, args[1]

  set: (record, scope, args) ->
    name = use record, scope, para[0]
    value = read record, scope, para[1]
    scope[name] = read

  if: (record, scope, args) ->
    cond = read record, scope, args[0]
    if cond
      run record, scope, args[1]
    else if args[2]?
      run record, scope, args[2]

  def: (record, scope, args) ->
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