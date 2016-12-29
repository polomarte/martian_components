# USE
# If the element is not a component, add full-height-header attribute to the tag.
# With a component, add 'full_height_header: true' to the persisted options
class @MC.Utils.FullHeightHeader
  @autoInit: ->
    $('[full-height-header]').each (i, el) => new @($(el))

  constructor: (@el) ->
    @el.data('fullHeightHeader', @)

    @component = @el.data('component')

    if @component
      @inner = @component.inner
    else
      @inner = @el

    @lastWidth = null

    @compute()

    $(window).on 'resize', =>
      @compute() unless @lastWidth == $(window).width()
      @lastWidth = $(window).width()

  compute: =>
    @inner.css('height', $(window).height() - @inner.offset().top)
    @el.trigger 'compute.fullHeightHeader.MC'
