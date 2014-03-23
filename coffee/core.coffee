
evaluate = require './evaluate'
{generate} = require 'cirru-writer'

run = (record, scope, exp) ->
  name = exp[0]
  args = exp[1..]
  if evaluate.registry[name]? then func = evaluate.registry[name]
  else func = scope.get name
  unless func? then throw new Error "not func: #{name}"
  func record, scope, args

read = (record, scope, exp) ->
  if typeof exp is 'string'
    guess = exp.match /(^-?\d+(\.\d+)?)/
    if guess? then Number guess[0]
    else scope.get exp
  else run record, scope, exp

use = (record, scope, exp) ->
  if typeof exp is 'string' then exp
  else run record, scope, exp

exports.read = read
exports.run = run
exports.use = use
