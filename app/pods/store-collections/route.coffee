`import Ember from 'ember'`

StoreCollectionsRoute = Ember.Route.extend
  model: -> @store.findAll 'store-collection'
  renderTemplate: ->
    @_super arguments...
    @render 'manage/secondary-sidebar',
      outlet: 'sidebar'
      into: 'store-collections'
  actions:
    saved: (collection) ->
      @transitionTo 'store-objects', collection

`export default StoreCollectionsRoute`
