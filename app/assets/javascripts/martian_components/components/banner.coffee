class @MC.Banner extends @MC.Base
  @autoInit: ->
    $('.component-banner').each (i, el) => new @($(el))

  constructor: (@el) ->
    super
