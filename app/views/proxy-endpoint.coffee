`import Ember from 'ember'`

ProxyEndpointView = Ember.View.extend
  layoutName: 'layouts/tertiary'
  didInsertElement: ->
    # TODO use a controller action rather than a direct call
    controller = @get 'controller'
    @$('.ap-list-nav-vertical-circle-icon').sortable
      items: 'li:not(.ap-unsortable)'
      update: (e, ui) ->
        id = $(ui.item).attr 'data-index'
        position = null
        $('[data-index]', @).each (i, item) ->
          position = i if $(item).is(ui.item)
        $(@).sortable 'cancel'
        ui.item.remove()
        Ember.run -> controller.moveComponentByIdTo id, position

`export default ProxyEndpointView`
