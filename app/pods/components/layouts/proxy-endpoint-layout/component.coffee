`import Ember from 'ember'`

LayoutsProxyEndpointLayoutComponent = Ember.Component.extend
  nav: 'navigations/proxy-endpoint/primary-nav'
  'secondary-nav': 'navigations/proxy-endpoint/secondary-nav'
  model: null

  componentMovedAction: 'componentMoved'

  didInsertElement: ->
    view = @
    @$('.ap-list-nav-vertical-circle-icon').sortable
      items: 'li:not(.ap-unsortable)'
      update: (e, ui) ->
        id = $(ui.item).attr 'data-index'
        position = null
        $('[data-index]', @).each (i, item) ->
          position = i if $(item).is(ui.item)
        #$(@).sortable 'cancel'
        #ui.item.remove()
        Ember.run -> view.send 'componentMoved', id, position
  actions:
    componentMoved: (id, position) ->
      @sendAction 'componentMovedAction', id, position

`export default LayoutsProxyEndpointLayoutComponent`
