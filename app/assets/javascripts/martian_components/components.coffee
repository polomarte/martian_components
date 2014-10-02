#= require_self
#= require ./components/base
#= require_tree ./components

class @Components
  class @Utils

  @autoInit: ->
    @Collapse.autoInit()
    @HoverGroup.autoInit()
    @Timeline.autoInit()
    @AffixNav.autoInit()
    @Tabs.autoInit()

    @Utils.LazySvg.autoInit()
