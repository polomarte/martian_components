class Admin.DependentSelectField
  @autoInit: ->
    $('select[dependent-select-field]').each (i, el) => new @ $(el)

  constructor: (@select) ->
    @parent = $("select[name='#{@select.data('dependsOn')}']")
    @options = $('option', @select)

    @parent.change @filterOptions
    @parent.trigger('change') if @select.val().length

  filterOptions: =>
    @options.show()

    if @options.filter('[selected]').data('dependsOnOptionId') != parseInt(@parent.val())
      @options.first().attr('selected', 'selected')

    @select.trigger('change')

    if @parent.val().length
      @select.attr('disabled', false)
      @options.filter('[data-depends-on-option-id]').not("[data-depends-on-option-id=#{@parent.val()}]").hide()
    else
      @select.attr('disabled', true)
