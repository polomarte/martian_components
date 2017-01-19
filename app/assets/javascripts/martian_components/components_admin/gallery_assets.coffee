class @MCAdmin.GalleryAssets
  @autoInit: ->
    init = =>
      $('form[id^=form_gallery] .assets-inputs').each (i, el) => new @($(el))

    $(document).on 'ajaxComplete', (ev, xhr) =>
      return false unless $(xhr.responseJSON?.component_form).length
      init()

    init()

  constructor: (@wrapper) ->
    @form = @wrapper.parents('form')

    @wrapper.on 'click', '.create-asset-btn', (ev) =>
      ev.preventDefault()
      @form.trigger('submitRequest')

    @wrapper.on 'cocoon:after-insert', =>
      @setPosition()

    @wrapper.on 'cocoon:after-remove', =>
      @setPosition()
      @form.trigger('submitRequest')

  setPosition: ->
    $('input[name$="[position]"]').each (i, el) -> $(el).val(i)
