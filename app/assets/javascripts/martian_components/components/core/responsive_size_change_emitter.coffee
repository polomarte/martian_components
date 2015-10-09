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
      when window.innerWidth < 768 then 'xs'
      when window.innerWidth >= 768 && window.innerWidth < 992 then 'sm'
      when window.innerWidth >= 992 && window.innerWidth < 1200 then 'md'
      when window.innerWidth >= 1200 then 'lg'

