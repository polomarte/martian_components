class @MC.Content extends @MC.Base
  @autoInit: ->
    $('.component-content').each (i, el) => new @($(el))

  constructor: (@el) ->
    super
