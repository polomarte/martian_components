class @ComponentsAdmin.NestedMenu
  @autoInit: ->
    new @($('#header #tabs li.has_nested'))

  constructor: (@rootItems) ->
    @SPLITTER = ' >> '

    @rootItems.each (i, rootItem) =>
      @groupItems $(rootItem).find('> ul')

  groupItems: (list) ->
    items = list.find('> li')
    itemsToGroup = items.filter (i, item) => return item.innerText.match(@SPLITTER)

    return unless itemsToGroup.length

    groupedItems = itemsToGroup.toArray().groupBy (item) =>
      item.innerText.split(@SPLITTER).first()

    Object.each groupedItems, (groupLabel, groupItems) =>
      groupListItem = $("<li><a href='#'>#{groupLabel}</a></li>")
      groupList = $('<ul></ul>')
      groupListItem.append(groupList)
      groupList.append(groupItems)

      $(groupItems).each (i, item) =>
        $('a', item).text item.innerText.split(@SPLITTER).last()

      prevListItemIndex = items.index(itemsToGroup.first())

      if typeof prevListItemIndex == 'number' && prevListItemIndex > 0
        prevListItem = items.eq(prevListItemIndex - 1)
        prevListItem.after(groupListItem)
      else
        $(list).append(groupListItem)

