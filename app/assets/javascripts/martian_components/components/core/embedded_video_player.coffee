class @MC.Core.EmbeddedVideoPlayerWrapper
  @autoInit: (@wrapper) ->
    $('.embedded-video-player-wrapper').each (i, wrapper) =>
      wrapper = $(wrapper)

      # Skip auto init if inside of a nested componenent
      if !wrapper.parents('[data-nested-level="1"]').length && !wrapper.data('player')
        new MC.Core.EmbeddedVideoPlayerWrapper(wrapper)

  constructor: (@wrapper) ->
    @player            = null
    @poster            = $('.embedded-video-player-poster', @wrapper)
    @placeholder       = $('.embedded-video-player-placeholder', @wrapper)
    @loader            = $('.loader', @poster)
    @playIcon          = $('.play-icon', @poster)
    @shouldModalOnPlay = @wrapper.data('modal')
    @videoId           = @placeholder.data('videoId')

    @initModal() if @shouldModalOnPlay

    @options =
      videoId: @videoId
      width: @wrapper.width()
      height: @wrapper.height()
      playerVars:
        modestbranding: true
        showinfo: 0
        rel: 0
        fs: if @shouldModalOnPlay then 0 else 1

    Utils.onFullscreenChange (ev) => @resetFromFullscreen()

    @poster.on 'click', => @onClickToPlay()

  onClickToPlay: ->
    if @shouldModalOnPlay
      @modal.modal('show')
    else
      @playIcon.hide()

      if !@player?
        @loader.show()
        @player = new YT.Player(@placeholder.attr('id'), @options)
        @wrapper.data 'player', @player

        @player.addEventListener 'onReady', =>
          @loader.hide()
          @player.playVideo()
          @poster.hide()
      else
        @player.playVideo()
        @poster.hide()

      if @shouldModalOnPlay
        iframe = $('iframe', @wrapper)[0]
        requestFullScreen = iframe.requestFullScreen || iframe.mozRequestFullScreen || iframe.webkitRequestFullScreen
        requestFullScreen.bind(iframe)() if requestFullScreen

  resetFromFullscreen: ->
    return if Utils.fullscreenElement() # Ignore if entering in fullscreen mode
    return if !@player

    @player.stopVideo?()
    @loader.hide()
    @poster.show()
    @playIcon.show()

  initModal: ->
    @modal = $("[id='modal-#{@videoId}']")
    @modalDismiss = $("[data-dismiss][data-target='#modal-#{@videoId}']")
    @modalEmbeddedPlayerWrapper = $('.embedded-video-player-wrapper', @modal)
    @modalPlayerPlaceholder = $('.modal-player-placeholder', @modal)

    loadPlayer = =>
      return if @modalPlayer

      @modalPlayer = new YT.Player(@modalPlayerPlaceholder.attr('id'),
        videoId: @videoId
        playerVars:
          modestbranding: true
          showinfo: 0
          rel: 0)

      @modalPlayer.addEventListener 'onReady', =>
        @modalPlayer.playVideo() unless Utils.isTouchDevice()

    @modal.modal({show: false})

    @modal.on 'shown.bs.modal', =>
      loadPlayer()
      @modalDismiss.show()

    @modal.on 'hide.bs.modal', =>
      @modalPlayer?.stopVideo?()
      @modalDismiss.hide()

    @modalDismiss.on 'touchstart click', =>
      @modal.modal('hide')
