#= require active_admin/base
#= require activeadmin-wysihtml5/base
# require jquery.fileupload
#= require s3_file_field
#= require bootstrap/tab
#= require bootstrap/transition
#= require ev-emitter/ev-emitter
#= require imagesloaded/imagesloaded
#= require sugar/sugar.min
#= require microplugin/microplugin
#= require sifter/sifter
#= require selectize/selectize
#= require cocoon
#= require martian_components/components_admin

#= require_self
#= require_tree ./admin

class @Admin

$ ->
  MCAdmin.autoInit()
  Admin.Wysihtml5Init.autoInit()
  Admin.TagsAutoComplete.autoInit()
  Admin.Selectize.autoInit()
  Admin.DependentSelectField.autoInit()

  $(document).on 'ready ajaxComplete', ->
    Admin.Uploader.autoInit()

    $('.datepicker').datepicker({dateFormat: 'dd/mm/yy'})
