class Admin.Selectize
  @autoInit: ->
    $('[data-selectize]').each (i, el) => new @ $(el)

  constructor: (@input) ->
    @select = @input.selectize()
