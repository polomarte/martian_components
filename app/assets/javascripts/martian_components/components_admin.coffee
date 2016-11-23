#= require_self
#= require_tree ./components_admin

class @MCAdmin
  @autoInit: ->
    @AutoSave.autoInit()
    @GalleryAssets.autoInit()
    @NestedMenu.autoInit()
    @RemoveMediaBtn.autoInit()
