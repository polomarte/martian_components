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

  # Based on http://gomakethings.com/how-to-get-the-value-of-a-querystring-with-native-javascript/
  @getQueryString: (field, url) ->
    href = url || window.location.href
    reg = new RegExp('[?&]' + field + '=([^&#]*)', 'i')
    string = reg.exec(href)

    if string
      decodeURIComponent(string[1]).replace(/\+/g, ' ')
    else
      null
