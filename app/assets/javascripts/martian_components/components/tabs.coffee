class @Components.Tabs extends @Components.Base
  @autoInit: ->
    $('.component-tabs').each (i, el) => new @($(el))

  constructor: (@el) ->
    super

    @nav              = $('.nav-tabs', @el)
    @navItems         = $('li', @nav)
    @nestedComponents = $('.tab-pane > article[class^="component-"]', @el)

    @nav.addClass('odd') if @navItems.length % 2 > 0

    $('a', @navItems).on 'shown.bs.tab', (ev) =>
      $(component).data('component').refresh() for component in @nestedComponents
