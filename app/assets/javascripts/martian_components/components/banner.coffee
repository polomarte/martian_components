class @MC.Banner extends @MC.Base
  @autoInit: ->
    $('.component-banner').each (i, el) => new @($(el))

  constructor: (@el) ->
    super
    @setupBackgroundVideoWrapper()

  setupBackgroundVideoWrapper: ->
    @backgroundVideoWrapper = $('.background-video-wrapper', @el)

    return unless @backgroundVideoWrapper.length

    video = $('video', @backgroundVideoWrapper)
    image = $('img', @backgroundVideoWrapper)

    video.css 'margin-left', '-9999px'
    image.css 'margin-left', '-9999px'

    @el.one 'compute.fullHeightHeader.MC', =>
      MC.Utils.FullscreenIntoParent.perform image
      image.css 'margin-left', '0'

    video.on 'canplaythrough', =>
      MC.Utils.FullscreenIntoParent.perform(video)
      video.css 'margin-left', '0'
