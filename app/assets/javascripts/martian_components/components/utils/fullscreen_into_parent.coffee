class @MC.Utils.FullscreenIntoParent
  @perform: (el) ->
    new @(el)

  constructor: (@el) ->
    @wrapper = @el.parent()

    @wrapper.css('position', 'relative') if @wrapper.css('position') == 'static'

    @compute()
    $(window).on 'resize', @compute

    # Some times @el.width() return wrong value because @el resizing is not finished yet
    # The below ensures slow computers display the content correctly
    setTimeout @compute, 500
    setTimeout @compute, 1000
    setTimeout @compute, 3000

  compute: =>
    wrapperWidth = @wrapper.width()
    wrapperHeight = @wrapper.height()

    # Scale
    if wrapperWidth / @el.width() > wrapperHeight / @el.height()
      @el.css width: wrapperWidth, height: 'auto'
    else
      @el.css width: 'auto', height: wrapperHeight

    # Centerize
    @el.css
      left: 0 - (@el.width() - wrapperWidth) / 2
      top: 0 - (@el.height() - wrapperHeight) / 2
