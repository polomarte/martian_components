#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap-sprockets
#= require sifter/sifter
#= require_tree ./polyfills
#= require_tree ../bower
#= require martian_components/components
#= require_self
#= require_tree ./application

################################################################################
class @App
  # @Settings:
  #   googleApiKey: 'xxxx'

  @ajaxSetup: ->
    $.ajaxSetup
      beforeSend: (xhr, settings) ->
        return if (settings.crossDomain)
        return if (settings.type == 'GET')

        token = $('meta[name="csrf-token"]').attr('content')
        xhr.setRequestHeader('X-CSRF-Token', token) if token.lenght

################################################################################
$(document).on 'ready page:load', ->
  App.ajaxSetup()
  MC.autoInit()

  # http://dotdotdot.frebsite.nl/
  $('[dotdotdot]').each (i, el) ->
    $(el).dotdotdot()

  # https://github.com/karacas/imgLiquid
  $('[data-liquid-fill]').imgLiquid()

$(document).on 'page:before-change', ->
  $('main').hide()
  $('footer').hide()
  $('.navbar [data-toggle="popover"]').popover('hide')

$(document).on 'page:restore', ->
  $('main').show()
  $('footer').show()
