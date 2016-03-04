class @MCAdmin.RemoveImageBtn
  @autoInit: ->
    init = =>
      $('.remove-image-btn').each (i, el) => new @($(el))

    $(document).on 'ajaxComplete', (ev, xhr) =>
      return false unless $(xhr.responseJSON?.component_form).length
      init()

    init()

  constructor: (@el) ->
    @destroyField = @el.parent().find('li[id$="_destroy_input"] input')

    @el.on 'click', (ev) =>
      ev.preventDefault()
      response = confirm('Deseja apagar esta imagem?')

      if response
        @destroyField.val('1')
        @destroyField.trigger('change')
