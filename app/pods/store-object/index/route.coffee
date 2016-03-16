`import Ember from 'ember'`

StoreObjectIndexRoute = Ember.Route.extend
  afterModel: -> @transitionTo 'store-object.edit'

`export default StoreObjectIndexRoute`
