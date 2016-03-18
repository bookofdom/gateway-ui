`import Ember from 'ember'`

StoreCollectionsIndexRoute = Ember.Route.extend
  afterModel: ->
    collection = @modelFor('store-collections').get 'firstObject'
    @transitionTo 'store-objects', collection

`export default StoreCollectionsIndexRoute`
