class @Components.Gallery extends @Components.Base
  class GalleryAsset
    constructor: (@el, @gallery) ->
      @embeddedPlayerWrapper = $('.embedded-video-player-wrapper', @el)
      @el.addClass('no-touch') unless Utils.isTouchDevice()

    stopVideo: ->
      @embeddedPlayerWrapper.data('player')?.stopVideo?()

  @autoInit: ->
    $('.component-gallery').each (i, el) => new @($(el))

  constructor: (@el) ->
    super

    @items  = []
    $('.gallery-asset', @el).each (i, el) => @items.push(new GalleryAsset($(el), @))

    @slider = $('[data-slick-carousel]', @el)
    @slider.attr('padding-gallery', true) if @options.padding
    @initSlider()

  initSlider: =>
    defaultOptions =
      slide:  '.gallery-asset'
      arrows: false
      dots:   true

    if @options.padding
      customOptions =
        centerMode:     true
        centerPadding:  '32%'
        slidesToShow:   1
        slidesToScroll: 1
        focusOnSelect:  true
        responsive: [
          {
            breakpoint: 1600
            settings: {centerPadding:  '28%'}
          }
          {
            breakpoint: 1100
            settings: {centerPadding:  '23%'}
          }
          {
            breakpoint: 600
            settings: {centerPadding: '10%'}
          }
        ]
    else
      customOptions =
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

    @slider.addClass('single-slide') if $('.gallery-asset', @el).length == 1

    @slider.slick Object.merge(
      defaultOptions,
      Object.merge(customOptions, @slider.data('gallery-options') || {}))

    @slider.on 'beforeChange', (ev, slick, currentSlide, nextSlide) =>
      if @items[currentSlide].embeddedPlayerWrapper.length
        @items[currentSlide].stopVideo()

  onResponsiveSizeChange: ->
    @slider.slick('slickGoTo', 0)
