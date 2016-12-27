class @Utils
  @isTouchDevice: ->
    typeof(window.ontouchstart) != 'undefined'

  @isXs: ->
    @currentResponsiveSize() == 'xs'

  @isSm: ->
    @currentResponsiveSize() == 'sm'

  @isMd: ->
    @currentResponsiveSize() == 'md'
    $(window).width() > 991

  @isLg: ->
    @currentResponsiveSize() == 'lg'

  @currentResponsiveSize: ->
    switch
      when $(window).width() < 768 then 'xs'
      when $(window).width() >= 768 && $(window).width() < 992 then 'sm'
      when $(window).width() >= 992 && $(window).width() < 1200 then 'md'
      when $(window).width() >= 1200 then 'lg'

  # Based on http://gomakethings.com/how-to-get-the-value-of-a-querystring-with-native-javascript/
  @getQueryString: (field, url) ->
    href = url || window.location.href
    reg = new RegExp('[?&]' + field + '=([^&#]*)', 'i')
    string = reg.exec(href)

    if string
      decodeURIComponent(string[1]).replace(/\+/g, ' ')
    else
      null

  @requestFullscreen: (el) ->
    el.webkitRequestFullscreen?(el)
    el.mozRequestFullScreen?(el)
    el.msRequestFullscreen?(el)
    el.webkitRequestFullscreen?(el)

  @exitFullscreen: ->
    document.webkitExitFullscreen?()
    document.mozCancelFullScreen?()
    document.msExitFullscreen?()
    document.webkitExitFullscreen?()
    document.webkitExitFullscreen?()

  @onExitFullscreen: (callback) ->
    document.addEventListener('webkitfullscreenchange', callback, false)
    document.addEventListener('mozfullscreenchange', callback, false)
    document.addEventListener('fullscreenchange', callback, false)
    document.addEventListener('MSFullscreenChange', callback, false)
