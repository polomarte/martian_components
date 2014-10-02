class @Components.Collapse extends @Components.Base
  @autoInit: ->
    $('.component-collapse').each (i, el) => new @($(el))

  constructor: (@el) ->
    @breakpoints = {sm: 750, md: 1000}

    super

    @text           = $('.text', @el)
    @collapseToggle = $('.toggle-wrapper button', @el)
    @text.dotdotdot watch: 'window'
    @onCollapseToggleClick()

    @fitText()
    $(window).load @fitText

  refresh: ->
    elementQuery()
    @closeCollapse()
    @fitText()

  fitText: =>
    @textCollapsedHeight = @computeTextCollapseHeight()
    @text.css height: @textCollapsedHeight
    @text.trigger('update')

  computeTextCollapseHeight: ->
    @text.css 'height', 0
    diff = @collapseToggle.offset().top - @text.offset().top - 30
    if diff < 160 then 160 else diff

  computeTextFullHeight: ->
    elClone = @el.clone()

    $('.text', elClone).css
      'width':       @text.width()
      'height':      'auto'
      'margin-left': '-9999px'
      'position':    'fixed'

    elClone.appendTo 'body'
    result = $('.text', elClone).height()
    elClone.remove()
    result

  openCollapse: ->
    @text.trigger('destroy')
    @text.css('height', @textCollapsedHeight) # Hack, 'cause .trigger('destroy') clean inline syle too
    @text.css 'overflow', 'hidden'
    @collapseToggle.velocity rotateX: '180deg'
    $.Velocity.animate(@text, height: @computeTextFullHeight()).then =>
      @text.open = true
      @text.css height: 'auto', overflow: ''

  closeCollapse: ->
    return unless @text.open
    @collapseToggle.velocity rotateX: '0deg'
    @text.css 'overflow', 'hidden'
    $.Velocity.animate(@text, height: @textCollapsedHeight).then =>
      @text.dotdotdot watch: 'window'
      @text.open = false
      @text.css 'overflow', ''

  onCollapseToggleClick: ->
    @collapseToggle.on 'click', =>
      return if @text.hasClass 'velocity-animating'
      if @text.open then @closeCollapse() else @openCollapse()

  onResponsiveSizeChange: ->
    @refresh()
