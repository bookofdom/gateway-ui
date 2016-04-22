`import Ember from 'ember'`

SharedComponentCallIndexRoute = Ember.Route.extend
  afterModel: -> @transitionTo 'shared-component-call.edit'

`export default SharedComponentCallIndexRoute`
