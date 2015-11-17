#= require_self
#= require_tree ./components_admin

class @ComponentsAdmin
  @autoInit: ->
    @AutoSave.autoInit()
    @GalleryAssets.autoInit()
