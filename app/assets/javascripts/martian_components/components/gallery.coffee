class @Components.Gallery extends @Components.Base
  class GalleryAsset
    constructor: (@el, @gallery) ->
      @embedded_player = $('.embedded-video-player-wrapper iframe', @el)
      @el.addClass('no-touch') unless Utils.isTouchDevice()

    stopVideo: ->
      src = @embedded_player.attr('src')
      @embedded_player.attr('src', '').attr('src', src)

  @autoInit: ->
    $('.component-gallery').each (i, el) => new @($(el))

  constructor: (@el) ->
    super

    @items  = []
    $('.gallery-asset', @el).each (i, el) => @items.push(new GalleryAsset($(el), @))

    @el.attr('padding-gallery', true) if @options.padding

    @slider = $('[data-slick-carousel]', @el)
    @initSlider()

  initSlider: =>
    defaultOptions =
      slide:  '.gallery-asset'
      arrows: false
      dots:   true
      slidesToShow:   3
      slidesToScroll: 3
      responsive:     [
        {
          breakpoint: 992
          settings:
            slidesToShow:   2
            slidesToScroll: 2
        },
        {
          breakpoint: 768
          settings:
            slidesToShow:   1
            slidesToScroll: 1
        }
      ]

    @slider.slick Object.merge(defaultOptions, @slider.data('gallery-options') || {})

    @slider.on 'beforeChange', (ev, slick, currentSlide, nextSlide) =>
      if @items[currentSlide].embedded_player.length
        @items[currentSlide].stopVideo()

  onResponsiveSizeChange: ->
    @slider.slick('slickGoTo', 0)
