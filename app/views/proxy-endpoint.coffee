`import Ember from 'ember'`

ProxyEndpointView = Ember.View.extend
  layoutName: 'layouts/tertiary'
  didInsertElement: ->
    controller = @get 'controller'
    view = @
    @$('.ap-list-nav-vertical-circle-icon').sortable
      exclude: '.ap-unsortable'
      update: (e, ui) ->
        id = $(ui.item).attr 'data-index'
        position = null
        $('[data-index]', @).each (i, item) ->
          position = i if $(item).is(ui.item)
        $(@).sortable 'cancel'
        ui.item.remove()
        Ember.run -> controller.moveComponentByIdTo id, position

`export default ProxyEndpointView`
