`import Ember from 'ember'`

CustomFunctionTestIndexRoute = Ember.Route.extend
  afterModel: -> @transitionTo 'custom-function-test.edit'

`export default CustomFunctionTestIndexRoute`
