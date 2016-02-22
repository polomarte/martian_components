class @Components.Utils.Analytics
  @autoInit: ->
    new @ if ga?

  constructor: ->
    $('.component-hover-group').each (i, el) => @setupForHoverGroup($(el))
    $('.component-social-feeds').each (i, el) => @setupForSocialFeeds($(el))

  setupForHoverGroup: (hoverGroup) ->
    $('.component-hover-item', hoverGroup).each (i, item) =>
      item = $(item)
      item.click =>
        ga 'send', 'event', hoverGroup.data('componentKey'), 'click', item.data('componentKey')

  setupForSocialFeeds: (socialFeeds) ->
    $('.social-feed', socialFeeds).each (i, item) =>
      item = $(item)
      item.click =>
        ga 'send', 'event', hoverGroup.data('componentKey'), 'click', item.attr('platform')
