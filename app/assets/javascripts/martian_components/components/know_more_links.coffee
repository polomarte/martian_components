class @MC.KnowMoreLinks extends @MC.Base
  @autoInit: ->
    $('.component-know-more-links').each (i, el) => new @($(el))

  constructor: (@el) ->
    super

    # Hover Items
    @items  = []
    $('.component-know-more-link', @el).each (i, el) =>
      @items.push new MC.KnowMoreLink($(el), @)
      
    @slider = $('[data-slick-carousel]', @el).not('[data-slick-carousel="false"]')

    @initSlider()

  initSlider: =>
    console.log("a");
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

    console.log(@slider)
    @slider.slick defaultOptions

  onResponsiveSizeChange: ->
    @items.map 'checkPlugins'
    @slider.slick('slickGoTo', 0)

  onResize: ->
    super
    @items.map 'adjustText'


class @MC.KnowMoreLink extends @MC.Base
  constructor: (@el, @KnowMoreLinks) ->
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
      container: @KnowMoreLinks.el
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