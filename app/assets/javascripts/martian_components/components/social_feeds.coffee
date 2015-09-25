class @Components.SocialFeeds extends @Components.Base
  @autoInit: ->
    $('.component-social_feeds').each (i, el) => new @($(el))

  constructor: (@el) ->
    super

    # Hover Items
    @items  = []
    $('article.social-feed', @el).each (i, el) =>
      @items.push new Components.SocialFeed($(el), @)

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

    @slider.on 'beforeChange', (ev, slick, currentSlide, nextSlide) =>
      if @items[currentSlide].embedded_player.length
        @items[currentSlide].stopVideo()

  onResponsiveSizeChange: ->
    @items.map 'checkPlugins'
    @slider.slick('slickGoTo', 0)


class @Components.SocialFeed
  constructor: (@el, @socialFeeds) ->
    @options         = @el.data('options')
    @embedded_player = $('.embedded-video-player-wrapper iframe', @el)
    # @modalToggle   = $('[data-toggle="modal"]', @el)

  checkPlugins: ->
    # if @options.modal then @initModal() else @disableModal()

  # initModal: ->
  #   @modalToggle.attr('data-toggle', 'modal')

  #   @modalDismiss    = $("[data-dismiss][data-target='#{@modalToggle.data('target')}']")
  #   @modal           = $(@modalToggle.data('target'))
  #   @embedded_player = $('.embedded-video-player-wrapper iframe', @el)

  #   @modal.on 'shown.bs.modal', =>
  #     @modalDismiss.show()

  #   @modal.on 'hide.bs.modal', =>
  #     @modalDismiss.hide()
  #     @stopVideo()

  #   @modalDismiss.on 'touchstart click', =>
  #     @modal.modal('hide')

  # disableModal: ->
  #   @modalToggle.removeAttr('data-toggle')

  stopVideo: ->
    src = @embedded_player.attr('src')
    @embedded_player.attr('src', '').attr('src', src)
