class @Components.Banner extends @Components.Base
  @autoInit: ->
    $('.component-banner').each (i, el) => new @($(el))

  constructor: (@el) ->
    @breakpoints = {sm: 750, md: 1000}
    super
