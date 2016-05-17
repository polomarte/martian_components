class @MC.Tabs extends @MC.Base
  @autoInit: ->
    $('.component-tabs').each (i, el) => new @($(el))

  constructor: (@el) ->
    super

    @nav              = $('.nav-tabs', @el)
    @navItems         = $('li', @nav)
    @nestedComponents = $('.tab-pane > article[class^="component-"]', @el)

    @nav.addClass('odd') if @navItems.length % 2 > 0

    @scrollOnLoad()

    $('a', @navItems).on 'shown.bs.tab', (ev, a) =>
      $(component).data('component').refresh() for component in @nestedComponents

      tabPane = $($(ev.delegateTarget).attr('href'))
      tabPaneComponent = $('[class^=component]', tabPane).first()
      tabPaneComponent.attr('id')
      location.hash = "#{@el.attr('id')}-#{tabPaneComponent.attr('id')}"

  scrollOnLoad: ->
    return unless location.hash.length

    component = @getComponentByHash(location.hash)

    if component.length
      componentTabId = component.parents('.tab-pane').attr('id')
      componentTab = $('[data-toggle]', @navItems).filter("[href='##{componentTabId}']")
      componentTab.tab('show')

      setTimeout =>
        $('html,body').animate({scrollTop: @el.offset().top}, 1000)
      , 500

  getComponentByHash: (hash) ->
    @nestedComponents.filter (i, component) =>
      return hash == "##{@el.attr('id')}-#{$(component).attr('id')}"
