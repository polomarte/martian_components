class @MC.Collapse extends @MC.Base
  @autoInit: ->
    $('.component-collapse').each (i, el) => new @($(el))

  constructor: (@el) ->
    super

    @text            = $('.text', @el).first()
    @textManualSplit = $('.text.manual-split', @el)
    @textToCollpase  = if @textManualSplit.length then @textManualSplit else @text
    @collapseToggle  = $('.toggle-wrapper svg', @el)
    @modalToggle     = $('> [data-toggle="modal"]', @inner)
    @modalDismiss    = $("[data-dismiss][data-target='#{@modalToggle.data('target')}']")
    @modal           = $(@modalToggle.data('target'))

    @modal.on 'shown.bs.modal',                  => @modalDismiss.show()
    @modal.on 'hide.bs.modal',                   => @modalDismiss.hide()
    @modalDismiss.on 'touchstart click',         => @modal.modal('hide')
    @collapseToggle.on 'click',                  => @onCollapseToggleClick()
    @textToCollpase.on $.support.transition.end, => @textToCollpase.trigger('update.dot')

    @text.height 'auto' if @text != @textToCollpases

    @textToCollpase.dotdotdot(watch: 'window')
    @fitText()

    setTimeout (=>
      @text.removeClass 'invisible'
      @textManualSplit.removeClass 'invisible'
    ), 700

  refresh: ->
    @closeCollapse()
    @fitText()
    @textToCollpase.css('opacity', 0)
    setTimeout (=> @textToCollpase.css('opacity', 1)), 700

  fitText: =>
    @textCollapsedHeight = @computeTextCollapseHeight()
    @textToCollpase.css height: @textCollapsedHeight

    setTimeout (=> @textToCollpase.trigger 'update.dot'), 700 # Fallback 1
    setTimeout (=> @textToCollpase.trigger 'update.dot'), 1500 # Fallback 2

  computeTextCollapseHeight: ->
    @textToCollpase.css 'height', 0

    collapseOrModalToggle =
      if @collapseToggle.is(':visible')
        @collapseToggle
      else
        @modalToggle

    diff = collapseOrModalToggle.offset().top - @text.offset().top - 30

    if @textToCollpase == @textManualSplit
      return 0
    else
      return if diff < 160 then 160 else diff

  computeTextFullHeight: ->
    elClone = @el.clone()

    elClone.css
      'width':       @el.width()
      'margin-left': '-9999px'
      'position':    'fixed'

    elCloneTextToCollapse =
      if @textManualSplit.length
        $('.text.manual-split', elClone)
      else
        $('.text', elClone)

    elCloneTextToCollapse.addClass('notransition')

    elCloneTextToCollapse.css
      height: 'auto'

    @el.after elClone
    result = elCloneTextToCollapse.height()
    elClone.remove()
    result

  openCollapse: ->
    return if @textToCollpase.open

    @textToCollpase.trigger('destroy')
    @textToCollpase.css('height', @textCollapsedHeight) # Hack, 'cause .trigger('destroy') clean inline syle too
    @textToCollpase.height @computeTextFullHeight()

    # Improve UX, applying fade in when possible (manual splitted text only)
    @textToCollpase.css('opacity', 1) if @textToCollpase.hasClass('manual-split')

    onOpen = =>
      @textToCollpase.trigger('update.dot')
      @textToCollpase.open = true
      @collapseToggle.attr 'class', 'text-open'

    @textToCollpase.on $.support.transition.end, onOpen
    setTimeout onOpen, 550 # Fallback 1
    setTimeout onOpen, 1500 # Fallback 2

    # Reactive dotdotdot
    setTimeout (=> @textToCollpase.dotdotdot(watch: 'window')), 2000

  closeCollapse: ->
    return unless @textToCollpase.open

    @textToCollpase.height @textCollapsedHeight
    $('body').stop().animate {scrollTop: @el.offset().top}

    # Improve UX, applying fade out when possible (manual splitted text only)
    @textToCollpase.css('opacity', 0) if @textToCollpase.hasClass('manual-split')

    onClose = =>
      @textToCollpase.open = false
      @collapseToggle.attr 'class', ''

    @textToCollpase.on $.support.transition.end, onClose
    setTimeout onClose, 550 # Fallback 1
    setTimeout onClose, 1500 # Fallback 2

  onCollapseToggleClick: ->
    if @textToCollpase.open then @closeCollapse() else @openCollapse()

  onResponsiveSizeChange: ->
    @refresh()
