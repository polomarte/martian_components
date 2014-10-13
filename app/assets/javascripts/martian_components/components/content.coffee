class @Components.Content extends @Components.Base
  @autoInit: ->
    $('.component-content').each (i, el) => new @($(el))

  constructor: (@el) ->
    @breakpoints =
      sm: 600
      md: 900

    super
