class @Components.Banner extends @Components.Base
  @autoInit: ->
    $('.component-banner').each (i, el) => new @($(el))

  constructor: (@el) ->
    super
