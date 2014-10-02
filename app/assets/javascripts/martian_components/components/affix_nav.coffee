class @Components.AffixNav extends @Components.Base
  @autoInit: ->
    $('.component-affix_nav').each (i, el) => new @($(el))

  constructor: (@el) ->
    @breakpoints =
      sm: 600
      md: 900

    super

    @el.affix
      offset:
        top: 372

    @fixWidth()
    @smoothScroll()
    $(window).resize @fixWidth

  smoothScroll: ->
    # Based on http://css-tricks.com/snippets/jquery/smooth-scrolling/
    $('a[href*=#]:not([href=#])', @el).on 'click', ->
      if location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname
        target = $(this.hash)
        target or=  $('[name=' + this.hash.slice(1) +']')

        if target.length
          $('html,body').animate({
            scrollTop: target.offset().top
          }, 1000)
          false

  fixWidth: =>
    @el.css 'width', @el.parent().width()
