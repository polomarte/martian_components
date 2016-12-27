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
