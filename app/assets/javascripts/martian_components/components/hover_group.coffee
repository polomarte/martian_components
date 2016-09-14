class @MC.HoverGroup extends @MC.Base
  @autoInit: ->
    $('.component-hover-group').each (i, el) => new @($(el))

  constructor: (@el) ->
    super

    # Hover Items
    @items  = []
    $('.component-hover-item', @el).each (i, el) =>
      @items.push new MC.HoverItem($(el), @)

    @slider = $('[data-slick-carousel]', @el).not('[data-slick-carousel="false"]')

    @initSlider()

    @items.map 'checkPlugins'
    @items.map 'adjustText'

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

    @slider.slick Object.merge(defaultOptions, @slider.data('gallery-options') || {})

  onResponsiveSizeChange: ->
    @items.map 'checkPlugins'
    @items.map 'adjustText'
    @slider.slick('slickGoTo', 0)

class @MC.HoverItem extends @MC.Base
  constructor: (@el, @hoverGroup) ->
    super

    @text        = $ $('[data-text]', @el).data('text')
    @hover       = $('[data-toggle="popover"]', @el)
    @modalToggle = $('.modal-trigger', @el)
    @modal       = $(@modalToggle.data('target'))

    @checkPlugins()

  adjustText: =>
    # Using timeout to hack this shit
    setTimeout (=> $('.text', @el).dotdotdot()), 0

  checkPlugins: ->
    if @modal.length then @initModal() else @disableModal()

    if @options.hover? && ((@options.hover == true) || (Utils.currentResponsiveSize() in @options.hover))
      @initHover()
    else
      @disableHover()

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

    @modalDismiss = $("[data-dismiss][data-target='#{@modalToggle.data('target')}']")
    @embeddedPlayerWrapper = $('.embedded-video-player-wrapper', @modal)

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
    @embeddedPlayerWrapper.data('player').stopVideo()
