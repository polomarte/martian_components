class @Components.Core.ResponsiveSizeChangeEmitter
  constructor: ->
    @currentResponsiveSize = @computeResponsiveSize()

    $(window).on 'resize', =>
      responsiveSize = @computeResponsiveSize()

      if @currentResponsiveSize != responsiveSize
        @currentResponsiveSize = responsiveSize
        $(window).trigger('responsiveSizeChange', @currentResponsiveSize)

  computeResponsiveSize: ->
    switch
      when $(window).width() < 768 then 'xs'
      when $(window).width() >= 768 && $(window).width() < 992 then 'sm'
      when $(window).width() >= 992 && $(window).width() < 1200 then 'md'
      when $(window).width() >= 1200 then 'lg'

