`import Ember from 'ember'`

StoreCollectionIndexRoute = Ember.Route.extend
  afterModel: -> @transitionTo 'store-collection.edit'

`export default StoreCollectionIndexRoute`
