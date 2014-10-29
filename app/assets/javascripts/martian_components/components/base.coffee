class @Components.Base
  constructor: (@el) ->
    @el.data('component', @)

    @options        = @el.data('options')
    @inner          = $('.inner:first', @el)
    @responsiveSize = null

    @setNestedCssClasses()

    # Executed on begin too
    addResizeListener(@el[0], @onResize)

  computeResponsiveSize: ->
    width = @inner.width()
    switch
      when width < @breakpoints.sm then 'xs'
      when width < @breakpoints.md then 'sm'
      else
        'md'

  refresh: ->
    console.log "#{@constructor.name} does not implement refresh"

  setNestedCssClasses: ->
    parentComponentLevels = @el.parents('article[class^="component-"]').length
    @el.attr('data-nested-level', parentComponentLevels)
    @inner.attr('data-nested-level', parentComponentLevels)

  onResize: =>
    @callResponsiveMethods()

  callResponsiveMethods: ->
    computeResponsiveSizeResult = @computeResponsiveSize()
    if computeResponsiveSizeResult != @responsiveSize
      @responsiveSize = computeResponsiveSizeResult
      @["onChangeTo#{@responsiveSize.camelize()}"]()
      @onResponsiveSizeChange()

  onResponsiveSizeChange: (newSize) -> console.log "#{@constructor.name} does not implement onResponsiveSizeChange"
  onChangeToXs: -> console.log "#{@constructor.name} does not implement onChangeToXs"
  onChangeToSm: -> console.log "#{@constructor.name} does not implement onChangeToSm"
  onChangeToMd: -> console.log "#{@constructor.name} does not implement onChangeToMd"
