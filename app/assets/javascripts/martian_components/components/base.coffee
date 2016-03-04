class @MC.Base
  constructor: (@el) ->
    @el.data('component', @)

    @options = @el.data('options') || {}
    @inner   = $('.inner:first', @el)

    @setNestedCssClasses()

    $(window).on 'responsiveSizeChange', (ev, responsiveSize) =>
      @callResponsiveMethods(responsiveSize)

    if @options.full_height_header
      @el.attr('full-height-header', true)

  refresh: ->
    console.log "#{@constructor.name} does not implement refresh"

  addResizeListener: ->

  setNestedCssClasses: ->
    parentComponentLevels = @el.parents('article[class^="component-"]').length
    @el.attr('data-nested-level', parentComponentLevels)
    @inner.attr('data-nested-level', parentComponentLevels)

  callResponsiveMethods: (responsiveSize) ->
    @["onChangeTo#{responsiveSize.camelize()}"]()
    @onResponsiveSizeChange(responsiveSize)

  onResponsiveSizeChange: (newSize) -> console.log "#{@constructor.name} does not implement onResponsiveSizeChange"
  onChangeToXs: -> console.log "#{@constructor.name} does not implement onChangeToXs"
  onChangeToSm: -> console.log "#{@constructor.name} does not implement onChangeToSm"
  onChangeToMd: -> console.log "#{@constructor.name} does not implement onChangeToMd"
  onChangeToLg: -> console.log "#{@constructor.name} does not implement onChangeToLg"
