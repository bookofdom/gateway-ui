`import Ember from 'ember'`

SharedComponentIndexRoute = Ember.Route.extend
  afterModel: -> @transitionTo 'shared-component.edit'

`export default SharedComponentIndexRoute`
