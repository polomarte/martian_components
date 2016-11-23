# USE
# If the element is not a component, add full-height-header attribute to the tag.
# With a component, add 'full_height_header: true' to the persisted options
class @MC.Utils.FullHeightHeader
  @autoInit: ->
    $('[full-height-header]').each (i, el) => new @($(el))

  constructor: (@el) ->
    @component = @el.data('component')

    if @component
      @inner = @component.inner
    else
      @inner = @el

    @lastWidth = null
    @offset = @inner.offset().top

    @compute()
    $(window).on 'resize', @compute

  compute: =>
    return false if @lastWidth == $(window).width()
    @inner.css('height', $(window).height() - @offset)
    @lastWidth = $(window).width()
    @el.trigger 'compute.fullHeightHeader.MC'
