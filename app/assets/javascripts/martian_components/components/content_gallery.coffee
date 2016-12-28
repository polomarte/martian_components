class @MC.ContentGallery extends @MC.Base
  class Item
    constructor: (@el, @gallery) ->
      @embeddedPlayerWrapper = $('.embedded-video-player-wrapper', @el)
      @el.addClass('no-touch') unless Utils.isTouchDevice()

    stopVideo: ->
      @embeddedPlayerWrapper.data('player')?.stopVideo?()

  @autoInit: ->
    $('.component-content-gallery').each (i, el) => new @($(el))

  constructor: (@el) ->
    super

    @items  = []
    $('.component-content', @el).each (i, el) => @items.push(new Item($(el), @))

    @slider = $('[data-slick-carousel]', @el)
    @slider.attr('padding-gallery', true)
    @initSlider()

  initSlider: =>
    options =
      slide:          '.component-content'
      arrows:         true
      dots:           true
      slidesToShow:   1
      slidesToScroll: 1
      focusOnSelect:  true
      responsive: [
        {
          breakpoint: 768
          settings: {arrows: false}
        }]

    if @slider.data('gallery-options')
      options = Object.merge(@slider.data('gallery-options'), options)

    @slider.addClass('single-slide') if $('.component-content', @el).length == 1
    @slider.slick options

    @slider.on 'beforeChange', (ev, slick, currentSlide, nextSlide) =>
      if @items[currentSlide].embeddedPlayerWrapper.length
        @items[currentSlide].stopVideo()

  onResponsiveSizeChange: ->
    @slider.slick('slickGoTo', 0)
