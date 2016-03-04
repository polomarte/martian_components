# USE
# Add smooth-scroll attribute to the element with anchors link.
# The target elements must have the id or name with the same value of the anchor's href
class @MC.Utils.SmoothScroll
  @autoInit: ->
    $('[smooth-scroll]').each (i, nav) => new @($(nav))

  constructor: (@nav) ->
    @offset = @nav.data('smooth-scroll-offset') || 0
    @scrollOnClick()
    @scrollOnLoad()

  scrollOnClick: ->
    # Based on http://css-tricks.com/snippets/jquery/smooth-scrolling/
    $('a[href*=#]:not([href=#])', @nav).on 'click', (ev) =>
      if location.pathname.replace(/^\//,'') == ev.delegateTarget.pathname.replace(/^\//,'') && location.hostname == ev.delegateTarget.hostname
        @scrollTo @getTargetByHash(ev.delegateTarget.hash)

  scrollOnLoad: ->
    setTimeout =>
      @scrollTo @getTargetByHash(location.hash)
    , 500

  scrollTo: (target) ->
    return unless target.length

    $('html,body').animate({
      scrollTop: target.offset().top - @offset
    }, 1000, => location.hash = target.attr('id'))
    false

  getTargetByHash: (hash) ->
    if $(hash).length then $(hash) else $("[name='#{hash.slice(1)}']")
