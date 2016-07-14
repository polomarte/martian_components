#= require ./utils
#= require_self
#= require ./components/base
#= require_tree ./components

class @MC
  class @Core
  class @Utils

  @autoInit: ->
    @AffixNav.autoInit()
    @Banner.autoInit()
    @Collapse.autoInit()
    @Content.autoInit()
    @ContentGallery.autoInit()
    @HoverGroup.autoInit()
    @Tabs.autoInit()
    @Timeline.autoInit()
    @SocialFeeds.autoInit()
    @Gallery.autoInit()
    @MegaLink.autoInit()
    @KnowMoreLinks.autoInit()

    @Utils.Analytics.autoInit()
    @Utils.LazySvg.autoInit()
    @Utils.FullHeightHeader.autoInit()
    @Utils.SmoothScroll.autoInit()

    new @Core.ResponsiveSizeChangeEmitter
    @Core.YoutubePlayerApiLoader.autoInit()
