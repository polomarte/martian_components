class @Components.Collapse extends @Components.Base
  @autoInit: ->
    $('.component-collapse').each (i, el) => new @($(el))

  constructor: (@el) ->
    super

    @text           = $('.text', @el).first()
    @collapsedText  = $('.text.collapse', @el)
    @collapseToggle = $('.toggle-wrapper svg', @el)
    @modalToggle  = $('> [data-toggle="modal"]', @inner)
    @modalDismiss = $("[data-dismiss][data-target='#{@modalToggle.data('target')}']")
    @modal        = $(@modalToggle.data('target'))

    @modal.on 'shown.bs.modal',          => @modalDismiss.show()
    @modal.on 'hide.bs.modal',           => @modalDismiss.hide()
    @modalDismiss.on 'touchstart click', => @modal.modal('hide')
    @collapseToggle.on 'click',          => @onCollapseToggleClick()

    if @collapsedText.length
      @collapsedText.collapse(toggle: false)
    else
      @text.dotdotdot(watch: 'window')
      @fitText()

  refresh: ->
    @closeCollapse()
    setTimeout (=> @fitText()), 300

  fitText: =>
    return if @collapsedText.length

    @textCollapsedHeight = @computeTextCollapseHeight()
    @text.css height: @textCollapsedHeight
    setTimeout (=> @text.trigger('update')), 300

  computeTextCollapseHeight: ->
    @text.css 'height', 0

    collapseOrModalToggle =
      if @collapseToggle.is(':visible')
        @collapseToggle
      else
        @modalToggle

    diff = collapseOrModalToggle.offset().top - @text.offset().top - 30
    if diff < 160 then 160 else diff

  computeTextFullHeight: ->
    elClone = @el.clone()

    elClone.css
      'width':       @el.width()
      'margin-left': '-9999px'
      'position':    'fixed'

    $('.text', elClone).css
      'height':   'auto'

    elClone.appendTo 'body'
    result = $('.text', elClone).height()
    elClone.remove()
    result

  openCollapse: ->
    return if @text.open

    @text.trigger('destroy')
    @text.css('height', @textCollapsedHeight) # Hack, 'cause .trigger('destroy') clean inline syle too
    @text.height @computeTextFullHeight()

    setTimeout (=>
      @text.open = true
      @collapseToggle.attr('class', 'text-open')
    ), 300

  closeCollapse: ->
    return unless @text.open

    @text.height @textCollapsedHeight
    $('body').stop().animate {scrollTop: @el.offset().top}

    setTimeout (=>
      @text.dotdotdot watch: 'window'
      @text.open = false
      @collapseToggle.attr('class', '')
    ), 300

  onCollapseToggleClick: ->
    if @collapsedText.length
      @collapsedText.collapse('toggle')

      if @collapseToggle.attr('class')?.length
        @collapseToggle.attr('class', '')
      else
        @collapseToggle.attr('class', 'text-open')
    else
      if @text.open then @closeCollapse() else @openCollapse()

  onResponsiveSizeChange: ->
    @refresh()
