# Fetch via ajax SVG file to able to edit it inline (like css fill property)
# Experiments with <object> was not successful (turbolinks conflicts).
class @MC.Utils.LazySvg
  @autoInit: ->
    $('[data-lazy-svg-url]').each (i, el) => new @($(el))

  constructor: (@el) ->
    $.get @el.data('lazy-svg-url'), (data) =>
      @el.replaceWith $(data).find('svg')
