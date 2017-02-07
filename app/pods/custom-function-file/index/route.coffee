`import Ember from 'ember'`

CustomFunctionFileIndexRoute = Ember.Route.extend
  afterModel: -> @transitionTo 'custom-function-file.edit'

`export default CustomFunctionFileIndexRoute`
