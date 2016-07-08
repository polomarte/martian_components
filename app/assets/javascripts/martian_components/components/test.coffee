class @MC.Test extends @MC.Base
  @autoInit: ->
    $('.component-test').each (i, el) => new @($(el))

  constructor: (@el) ->
    super
