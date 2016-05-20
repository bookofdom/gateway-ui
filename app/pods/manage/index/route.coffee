`import Ember from 'ember'`

ManageIndexRoute = Ember.Route.extend
  afterModel: -> @transitionTo 'store-collections.index'

`export default ManageIndexRoute`
