class @Components.SocialFeeds extends @Components.Base
  @autoInit: ->
    $('.component-social-feeds').each (i, el) => new @($(el))

  constructor: (@el) ->
    super

    @items  = []
    $('article.social-feed', @el).each (i, el) =>
      @items.push new Components.SocialFeed($(el), @)

    @slider = $('[data-slick-carousel]', @el).not('[data-slick-carousel="false"]')
    @initSlider()

  initSlider: =>
    defaultOptions =
      slide:          'article'
      dots:           true
      centerMode:     true
      centerPadding:  '32%'
      slidesToShow:   1
      slidesToScroll: 1
      arrows:         false
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

  stopVideo: ->
    src = @embedded_player.attr('src')
    @embedded_player.attr('src', '').attr('src', src)
