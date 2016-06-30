class Admin.TagsAutoComplete
  @autoInit: ->
    $('[data-tags-autocomplete]').each (i, el) => new @ $(el)

  constructor: (@input) ->
    if @input.data('createNewTag')
      @options =
        items:       @input.data('persisted')
        options:     @input.data('collection')
        labelField:  'name'
        valueField:  'id'
        searchField: ['name']
        create:      @createTag
    else
      @options = {}

    @select = @input.selectize @options
    @selectize = @select[0].selectize

    @newItemInput = $('+ .selectize-control', @input).find('.selectize-input.items input')

    # sortable = new Sortable($('.selectize-input.items')[0], {
    #   draggable: '.item'
    # })

  createTag: (input, callback) =>
    promise = $.ajax
      type: 'POST'
      url: @input.data('createNewTagUrl')
      dataType: 'json'
      data: {"#{@input.data('createNewTagParamsWrapper')}": {name: input}}

    promise.success (data) =>
      @selectize.addOption({id: data.id, name: data.name})
      @selectize.addItem(data.id)

      @newItemInput.val('')

    promise.fail (data) ->
      window.alert 'Não foi possível criar tag.'
      console.error data.responseJSON.errors
