`import Ember from 'ember'`

StoreCollectionsRoute = Ember.Route.extend
  model: -> @store.findAll 'store-collection'
  actions:
    saved: (collection) ->
      @transitionTo 'store-objects', collection

`export default StoreCollectionsRoute`
