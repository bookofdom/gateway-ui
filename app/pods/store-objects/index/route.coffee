`import Ember from 'ember'`

StoreObjectsIndexRoute = Ember.Route.extend
  setupController: (controller) ->
    controller.set 'store_collection', @modelFor('store-collection')
    @_super arguments...

`export default StoreObjectsIndexRoute`
