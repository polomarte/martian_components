#= require_self
#= require ./components/base
#= require_tree ./components

class @Components
  class @Utils

  @autoInit: ->
    @AffixNav.autoInit()
    @Collapse.autoInit()
    @Content.autoInit()
    @HoverGroup.autoInit()
    @Tabs.autoInit()
    @Timeline.autoInit()

    @Utils.LazySvg.autoInit()
