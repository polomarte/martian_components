class @Admin.Wysihtml5Init
  @autoInit: ->
    new Admin.Wysihtml5Init

  constructor: ->
    @init()
    $(document).on 'ajaxComplete', @init

  init: =>
    $('.activeadmin-wysihtml5').activeAdminWysihtml5()
