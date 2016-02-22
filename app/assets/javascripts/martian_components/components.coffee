#= require ./utils
#= require_self
#= require ./components/base
#= require_tree ./components

class @Components
  class @Core
  class @Utils

  @autoInit: ->
    @AffixNav.autoInit()
    @Banner.autoInit()
    @Collapse.autoInit()
    @Content.autoInit()
    @HoverGroup.autoInit()
    @Tabs.autoInit()
    @Timeline.autoInit()
    @SocialFeeds.autoInit()
    @Gallery.autoInit()
    @MegaLink.autoInit()

    @Utils.Analytics.autoInit()
    @Utils.YoutubePlayerApiLoader.autoInit()
    @Utils.LazySvg.autoInit()
    @Utils.FullHeightHeader.autoInit()
    @Utils.SmoothScroll.autoInit()

    new @Core.ResponsiveSizeChangeEmitter
