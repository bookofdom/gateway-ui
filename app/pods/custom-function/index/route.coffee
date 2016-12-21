`import Ember from 'ember'`

CustomFunctionIndexRoute = Ember.Route.extend
  afterModel: -> @transitionTo 'custom-function.edit'

`export default CustomFunctionIndexRoute`
