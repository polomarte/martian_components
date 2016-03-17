class @MC.Core.YoutubePlayerApiLoader
  @autoInit: ->
    @.instance = new @ if $('.embedded-video-player-wrapper').length

  constructor: ->
    window.onYouTubeIframeAPIReady = @onYouTubeIframeAPIReady
    @loadApi()

  loadApi: ->
    tag = document.createElement('script')
    tag.src = "//www.youtube.com/iframe_api"
    firstScriptTag = document.getElementsByTagName('script')[0]
    firstScriptTag.parentNode.insertBefore(tag, firstScriptTag)

  onYouTubeIframeAPIReady: ->
    instance = MC.Core.YoutubePlayerApiLoader.instance
    $(instance).trigger('apiReady')

    $('.embedded-video-player-wrapper').each (i, wrapper) =>
      wrapper = $(wrapper)

      # Skip auto init if inside of a nested componenent
      if !wrapper.parents('[data-nested-level="1"]').length
        instance.setupWrapper(wrapper)

  setupWrapper: (wrapper) ->
    return if wrapper.data('player')

    poster = $('.embedded-video-player-poster', wrapper)
    placeholder = $('.embedded-video-player-placeholder', wrapper)

    options =
      videoId: placeholder.data('videoId')
      width: wrapper.width()
      height: wrapper.height()
      playerVars:
        modestbranding: true
        showinfo: 0
        rel: 0

    poster.one 'click', =>
      $('.loader', poster).show()
      $('.play-icon', poster).hide()

      player = new YT.Player(placeholder.attr('id'), options)
      wrapper.data 'player', player

      player.addEventListener 'onReady', =>
        player.playVideo()
        poster.hide()
