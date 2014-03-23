
exports.Scope = class Scope
  constructor: -> @data = {}
  set: (key, value) -> @data[key] = value
  get: (key) ->
    ret = @data[key]
    unless ret?
      if @parent? then ret = @parent.get key
    ret
  new: ->
    child = new Scope
    child.parent = @
    child