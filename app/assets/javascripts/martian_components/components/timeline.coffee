class @Components.Timeline extends @Components.Base
  @autoInit: ->
    $('.component-timeline').each (i, el) => new @($(el))

  constructor: (@el) ->
    @breakpoints =
      sm: 600
      md: 900

    super

    @text      = $ $('[data-text]', @el).data('text')
    @navSlider = $('[data-jq-slider]', @el)
    @slider    = $('[data-slick-carousel]', @el)

    @initNavSlider()
    @initSlider()

  initNavSlider: =>
    yearsEl     = @navSlider.find('.years')
    yearsValues = yearsEl.data('values')

    yearsValues.each (item, index) ->
      year = $("<div class='year'>#{item}</div>")
      year.css('left', (100 / (yearsValues.length - 1) * index) + '%')
      year.appendTo yearsEl

    @navSlider.slider
      values: [0]
      step:   yearsValues.length - 1

    @navSlider.on 'slide', (ev, ui) =>
      @slider.find('.slick-track')[0].style.webkitAnimationPlayState = 'paused'
      @slider.slickGoTo(ui.value / 10)

  initSlider: =>
    @slider.slick
      slide:          'article'
      slidesToShow:   1
      arrows:         true
      responsive:     [
        {
          breakpoint: 500
          settings:
            dots:   true
        }
      ]
      onBeforeChange: (slider, current, next) =>
        @navSlider.slider('values', 0, next * 10)
