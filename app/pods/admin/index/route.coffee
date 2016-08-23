`import Ember from 'ember'`

AdminIndexRoute = Ember.Route.extend
  afterModel: -> @transitionTo 'account'

`export default AdminIndexRoute`
