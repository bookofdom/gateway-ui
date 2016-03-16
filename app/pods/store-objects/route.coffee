`import Ember from 'ember'`

StoreObjectsRoute = Ember.Route.extend
  model: -> @modelFor('store-collection').get 'store_objects'

`export default StoreObjectsRoute`
