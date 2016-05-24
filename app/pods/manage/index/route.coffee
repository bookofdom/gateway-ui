`import Ember from 'ember'`

ManageIndexRoute = Ember.Route.extend
  afterModel: -> @transitionTo 'store-collections'

`export default ManageIndexRoute`
