class @MC.KnowMoreLinks extends @MC.Base
  @autoInit: ->
    $('.component-know-more-links').each (i, el) => new @($(el))

  constructor: (@el) ->
    super

    @Links  = []
    $('.component-know-more-links', @el).each (i, el) =>
      @Links.push new MC.KnowMoreLink($(el), @)

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

    @slider.slick Object.merge(defaultOptions, @slider.data('gallery-options') || {})
