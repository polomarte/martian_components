class @Components.Content extends @Components.Base
  @autoInit: ->
    $('.component-content').each (i, el) => new @($(el))

  constructor: (@el) ->
    super
