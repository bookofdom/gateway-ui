`import Ember from 'ember'`

CustomFunctionTestsRoute = Ember.Route.extend
  model: -> @modelFor('custom-function').get 'tests'
  actions:
    saved: ->
      # no op (this event is for use by the new type test route)

`export default CustomFunctionTestsRoute`
