class @Components.Core.YoutubePlayerApiLoader
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
    $('.embedded-video-player-wrapper').each (i, wrapper) =>
      wrapper = $(wrapper)

      # Skip auto init if inside of a nested componenent
      if !wrapper.parents('[data-nested-level="1"]').length
        Components.Core.YoutubePlayerApiLoader.instance.setupWrapper(wrapper)

  setupWrapper: (wrapper) ->
    placeholder = $('.embedded-video-player-placeholder', wrapper)

    options =
      videoId: placeholder.data('videoId')
      width: wrapper.width()
      height: wrapper.height()
      playerVars:
        modestbranding: true
        showinfo: 0
        rel: 0

    player = new YT.Player(placeholder.attr('id'), options)

    wrapper.data 'player', player

