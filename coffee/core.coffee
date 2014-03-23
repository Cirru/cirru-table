
evaluate = require './evaluate'
{generate} = require 'cirru-writer'

run = (record, scope, exp) ->
  record.push 'run: ' + (generate [[exp]])
  func = exp[0]
  args = exp[1..]
  if typeof func is 'string'
    if evaluate.registry[func]?
      ret = evaluate.registry[func] record, scope, args
    else if scope[func]?
      ret = scope[func] record, scope, args
  else
    solution = read record, scope, func
    if typeof solution is 'function'
      ret = solution record, scope, args
    else
      throw new Error
  ret

read = (record, scope, exp) ->
  if typeof exp is 'string'
    guess = exp.match /(^\d+(\.\d+)?)/
    if guess?
      Number guess[0]
    else
      scope[exp]
  else
    run record, scope, exp

use = (record, scope, exp) ->
  if typeof exp is 'string'
    exp
  else
    run record, scope, exp

exports.read = read
exports.run = run
exports.use = use
