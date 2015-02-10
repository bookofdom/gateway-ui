`import Ember from 'ember'`

ProxyEndpointView = Ember.View.extend
  layoutName: 'layouts/tertiary'
  didInsertElement: ->
    view = @
    @$('.ap-list-nav-vertical-circle-icon').sortable
      items: 'li:not(.ap-unsortable)'
      update: (e, ui) ->
        id = $(ui.item).attr 'data-index'
        position = null
        $('[data-index]', @).each (i, item) ->
          position = i if $(item).is(ui.item)
        $(@).sortable 'cancel'
        ui.item.remove()
        Ember.run -> view.send 'componentMoved', id, position
  actions:
    componentMoved: (id, position) ->
      @get('controller').send 'componentMoved', id, position

`export default ProxyEndpointView`
