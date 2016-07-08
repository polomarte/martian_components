class @MC.KnowMoreLinks extends @MC.Base
  @autoInit: ->
    $('.component-know-more-links').each (i, el) => new @($(el))

  constructor: (@el) ->
    super
