class @Components.Timeline extends @Components.Base
  @autoInit: ->
    $('.component-timeline').each (i, el) => new @($(el))

  constructor: (@el) ->
    super

    @text      = $ $('[data-text]', @el).data('text')
    @navSlider = $('[data-jq-slider]', @el)
    @slider    = $('[data-slick-carousel]', @el)

    @initNavSlider()
    @initSlider()

  initNavSlider: =>
    @yearsWrapper      = @navSlider.find('.years')
    @yearsValues       = @yearsWrapper.data('values')
    @navSliderStepSize = (100 / (@yearsValues.length - 1))

    @yearsValues.each (item, index) =>
      year = $("<div class='year'>#{item}</div>")
      year.css('left', (@navSliderStepSize * index) + '%')
      year.appendTo @yearsWrapper

    @years = @yearsWrapper.find('.year')

    @years.first().addClass 'active'

    @navSlider.slider
      values: [0]
      step:   @navSliderStepSize

    @navSlider.on 'slide', (ev, ui) =>
      @slider.find('.slick-track')[0].style.webkitAnimationPlayState = 'paused'
      newPositionIndex = (ui.value / @navSliderStepSize).round()
      @slider.slick('slickGoTo', newPositionIndex)
      @updateActiveYear newPositionIndex

  initSlider: =>
    @slider.slick
      slide:          'article'
      slidesToShow:   1
      responsive:     [
        {
          breakpoint: 720
          settings:
            dots:   true
            arrows: false
        }
      ]
      onBeforeChange: (slider, current, next) =>
        @navSlider.slider('values', 0, next * @navSliderStepSize)
        @updateActiveYear next

  updateActiveYear: (newIndex) ->
    @years.removeClass 'active'
    @years.eq(newIndex).addClass 'active'
