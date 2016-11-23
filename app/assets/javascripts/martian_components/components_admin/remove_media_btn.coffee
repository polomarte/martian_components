class @MCAdmin.RemoveMediaBtn
  @autoInit: ->
    init = =>
      $('.remove-media-btn').each (i, el) => new @($(el))

    $(document).on 'ajaxComplete', (ev, xhr) =>
      return false unless $(xhr.responseJSON?.component_form).length
      init()

    init()

  constructor: (@el) ->
    @destroyField = @el.parent().find('input[name*="remove"]')

    if !@destroyField.length
      @destroyField = @el.parent().find('input[name*="destroy"]')

    @el.on 'click', (ev) =>
      ev.preventDefault()
      response = confirm('Deseja apagar esta imagem?')

      if response
        @destroyField.val('1')
        @destroyField.trigger('change')
