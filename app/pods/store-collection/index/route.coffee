`import Ember from 'ember'`

StoreCollectionIndexRoute = Ember.Route.extend
  afterModel: -> @transitionTo 'store-objects'

`export default StoreCollectionIndexRoute`
