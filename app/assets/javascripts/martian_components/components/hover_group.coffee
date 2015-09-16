class @Components.HoverGroup extends @Components.Base
  @autoInit: ->
    $('.component-hover_group').each (i, el) => new @($(el))

  constructor: (@el) ->
    @breakpoints =
      sm: 600
      md: 900

    super

    # Hover Items
    @items  = []
    $('.component-hover_item', @el).each (i, el) =>
      @items.push new Components.HoverItem($(el), @)

    @slider = $('[data-slick-carousel]', @el).not('[data-slick-carousel="false"]')

    @initSlider()

  initSlider: =>
    defaultOptions =
      slide:          'article'
      slidesToShow:   4
      slidesToScroll: 4
      dots:           true
      arrows:         true
      responsive:     [
        {
          breakpoint: 1200
          settings:
            slidesToShow:   3
            slidesToScroll: 3
        }
        {
          breakpoint: 767
          settings:
            slidesToShow:   1
            slidesToScroll: 1
        }
      ]

    customOptions = @slider.data('gallery-options') || {}

    @slider.slick Object.merge(defaultOptions, customOptions)

  onResponsiveSizeChange: ->
    @items.map 'checkPlugins'
    @slider.slickGoTo(0)

  onResize: ->
    super
    @items.map 'adjustText'


class @Components.HoverItem extends @Components.Base
  constructor: (@el, @hoverGroup) ->
    @breakpoints =
      sm: 400
      md: 700

    super

    @text        = $ $('[data-text]', @el).data('text')
    @hover       = $('[data-toggle="popover"]', @el)
    @modalToggle = $('[data-toggle="modal"]', @el)

  adjustText: =>
    # Using timeout to hack this shit
    setTimeout (=>$('.text', @el).dotdotdot()), 0

  checkPlugins: ->
    if @options.hover_group
      if @options.hover_group[@hoverGroup.responsiveSize]?.hover then @initHover() else @disableHover()
      if @options.hover_group[@hoverGroup.responsiveSize]?.modal then @initModal() else @disableModal()
    else
      if @options.modal then @initModal() else @disableModal()

  initHover: ->
    @hover.popover
      trigger:   'hover'
      placement: 'bottom'
      container: @hoverGroup.el
      html:      true

  disableHover: ->
    @hover.popover('destroy')

  initModal: ->
    @modalToggle.attr('data-toggle', 'modal')

    @modalDismiss    = $("[data-dismiss][data-target='#{@modalToggle.data('target')}']")
    @modal           = $(@modalToggle.data('target'))
    @embedded_player = $('.embedded-video-player-wrapper iframe', @modal)

    @modal.on 'shown.bs.modal', =>
      @modalDismiss.show()

    @modal.on 'hide.bs.modal', =>
      @modalDismiss.hide()
      @stopVideo()

    @modalDismiss.on 'touchstart click', =>
      @modal.modal('hide')

  disableModal: ->
    @modalToggle.removeAttr('data-toggle')

  stopVideo: ->
    src = @embedded_player.attr('src')
    @embedded_player.attr('src', '').attr('src', src)
