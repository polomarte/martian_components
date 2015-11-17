class @ComponentsAdmin.AutoSave
  @autoInit: ->
    $('form[data-autosave]').each (i, el) => new @($(el))

  constructor: (@el) ->
    @setupAjaxCallbacks()
    @setupWysiwygInputs()
    @setupHTMLInputs()

    @el.on 'submitRequest', => @submit()

  setupAjaxCallbacks: ->
    $(document).on 'ajaxSend', =>
      @notify 'sending'

    $(document).on 'ajaxComplete', (ev, xhr) =>
      form = $(xhr.responseJSON?.component_form)

      return false unless form.length

      # Reassign form when form is wrapper by another tag
      form = form.find('form').first() if form[0].tagName != 'FORM'

      return unless form.length
      return unless form.attr('id') == @el.attr('id')

      $('body').css('height', $(document).height()) # Prevent page bounce (not SEO!)
      @el.html form.html()
      setTimeout((-> $('body').css('height', 'auto')), 50) # Prevent page bounce (not SEO!)

      @setupWysiwygInputs()
      @setupHTMLInputs()
      @notify xhr.statusText

  setupWysiwygInputs: ->
    $('.activeadmin-wysihtml5', @el).on 'activeadmin-wysihtml5:load', (ev) =>
      $(ev.target).data('editor').on 'change:composer', => @submit(ev.target)

  setupHTMLInputs: ->
    $('input, textarea', @el).on 'change', (ev) =>
      @submit(ev.currentTarget)

  submit: (input) ->
    if input
      form = $(input).parents('form')
    else
      form = @el

    $.ajax
      url:         form.attr('action')
      method:      form.attr('method')
      data:        new FormData(form[0])
      dataType:    form.data('type')
      contentType: false
      processData: false

  notify: (status) ->
    info = switch status
      when 'OK'      then {label: 'Salvo!', cssClass: 'success'}
      when 'sending' then {label: 'Salvando...', cssClass: 'sending'}
      else {label: 'Ops :(', cssClass: 'failure'}

    el = $('.autosave')

    if el.length
      el.removeClass 'success'
      el.removeClass 'sending'
      el.removeClass 'failure'
    else
      el = $("<div class='autosave'></div>")
      el.appendTo('body')
      setTimeout (=> el.addClass('active')), 50

    el.addClass info.cssClass
    el.text info.label

    clearTimeout @lastNotifyTimeoutID

    unless status == 'sending'
      @lastNotifyTimeoutID = setTimeout (=>
        el.removeClass('active')
        setTimeout (=> el.remove()), 500
      ), 2000
