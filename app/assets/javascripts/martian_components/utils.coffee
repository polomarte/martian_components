class @Utils
  @isTouchDevice: ->
    typeof(window.ontouchstart) != 'undefined'

  @isXs: ->
    @currentResponsiveSize() == 'xs'

  @isSm: ->
    @currentResponsiveSize() == 'sm'

  @isMd: ->
    @currentResponsiveSize() == 'md'
    window.innerWidth > 991

  @isLg: ->
    @currentResponsiveSize() == 'lg'

  @currentResponsiveSize: ->
    switch
      when window.innerWidth < 768 then 'xs'
      when window.innerWidth >= 768 && window.innerWidth < 992 then 'sm'
      when window.innerWidth >= 992 && window.innerWidth < 1200 then 'md'
      when window.innerWidth >= 1200 then 'lg'
