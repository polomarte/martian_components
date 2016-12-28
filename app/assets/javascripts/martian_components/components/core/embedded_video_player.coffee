class @MC.Core.EmbeddedVideoPlayerWrapper
  @autoInit: (@wrapper) ->
    $('.embedded-video-player-wrapper').each (i, wrapper) =>
      wrapper = $(wrapper)

      # Skip auto init if inside of a nested componenent
      if !wrapper.parents('[data-nested-level="1"]').length && !wrapper.data('player')
        new MC.Core.EmbeddedVideoPlayerWrapper(wrapper)

  constructor: (@wrapper) ->
    @player      = null
    @poster      = $('.embedded-video-player-poster', @wrapper)
    @placeholder = $('.embedded-video-player-placeholder', @wrapper)
    @loader      = $('.loader', @poster)
    @playIcon    = $('.play-icon', @poster)

    @options =
      videoId: @placeholder.data('videoId')
      width: @wrapper.width()
      height: @wrapper.height()
      playerVars:
        modestbranding: true
        showinfo: 0
        rel: 0

    Utils.onExitFullscreen =>
      @player.stopVideo?()
      @loader.hide()
      @poster.show()

    @poster.one 'click', =>
      @loader.show()
      @playIcon.hide()

      @player = new YT.Player(@placeholder.attr('id'), @options)
      @wrapper.data 'player', @player

      # TODO: Refact this. Gallery component should be responsable for this action
      if @wrapper.parents('.mosaic-wrapper').length || @wrapper.data('fullscreen')
        iframe = $('iframe', @wrapper)[0]
        requestFullScreen = iframe.requestFullScreen || iframe.mozRequestFullScreen || iframe.webkitRequestFullScreen
        requestFullScreen.bind(iframe)() if requestFullScreen

      @player.addEventListener 'onReady', =>
        @player.playVideo()
        @poster.hide()
