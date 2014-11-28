class @Components.Collapse extends @Components.Base
  @autoInit: ->
    $('.component-collapse').each (i, el) => new @($(el))

  constructor: (@el) ->
    @breakpoints = {sm: 750, md: 1000}

    super

    @text           = $('.text', @el)
    @collapseToggle = $('.toggle-wrapper button', @el)

    @initModal()
    @text.dotdotdot watch: 'window'
    @onCollapseToggleClick()

  refresh: ->
    @closeCollapse()
    @fitText()

  initModal: ->
    @modalToggle  = $('> .inner > [data-toggle="modal"]', @el)
    @modalDismiss = $("[data-dismiss][data-target='#{@modalToggle.data('target')}']")
    @modal        = $(@modalToggle.data('target'))

    @modal.on 'shown.bs.modal', =>
      @modalDismiss.show()

    @modal.on 'hide.bs.modal', =>
      @modalDismiss.hide()

    @modalDismiss.on 'touchstart click', =>
      @modal.modal('hide')

  fitText: =>
    setTimeout =>
      @textCollapsedHeight = @computeTextCollapseHeight()
      @text.css height: @textCollapsedHeight
      @text.trigger('update')
    , 0

  computeTextCollapseHeight: ->
    @text.css 'height', 0

    collapse_or_modal_toggle =
      if @collapseToggle.is(':visible')
        @collapseToggle
      else
        @modalToggle

    diff = collapse_or_modal_toggle.offset().top - @text.offset().top - 30
    if diff < 160 then 160 else diff

  computeTextFullHeight: ->
    elClone = @el.clone()

    elClone.css
      'width':       @el.width()
      'margin-left': '-9999px'
      'position':    'fixed'

    $('.text', elClone).css
      'height':   'auto'
      'overflow': ''

    elClone.appendTo 'body'
    result = $('.text', elClone).height()
    elClone.remove()
    result

  openCollapse: ->
    return if @text.open
    @text.trigger('destroy')
    @text.css('height', @textCollapsedHeight) # Hack, 'cause .trigger('destroy') clean inline syle too
    @text.css 'overflow', 'hidden'
    @collapseToggle.velocity rotateX: '180deg', translateZ: '-1px'

    @text.velocity
      height: @computeTextFullHeight()
    ,
      complete: =>
        @text.open = true
        @text.css overflow: ''

  closeCollapse: ->
    return unless @text.open
    @collapseToggle.velocity rotateX: '0deg', translateZ: '0px'
    @text.css 'overflow', 'hidden'

    @text.velocity
      height: @textCollapsedHeight
    ,
      complete: =>
        @text.dotdotdot watch: 'window'
        @text.open = false
        @text.css 'overflow', ''

  onCollapseToggleClick: ->
    @collapseToggle.on 'click', =>
      return if @text.hasClass 'velocity-animating'
      if @text.open then @closeCollapse() else @openCollapse()

  onResponsiveSizeChange: ->
    @refresh()
