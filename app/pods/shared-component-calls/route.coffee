`import Ember from 'ember'`

SharedComponentCallsRoute = Ember.Route.extend
  model: -> @modelFor('shared-component').get 'calls'

`export default SharedComponentCallsRoute`
