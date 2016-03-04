class @MC.MegaLink extends @MC.Base
  @autoInit: ->
    $('.component-mega-link').each (i, el) => new @($(el))

  constructor: (@el) ->
    @card = $('.card', @el)

    @card.addClass('no-touch') unless Utils.isTouchDevice()
