`import Ember from 'ember'`

CustomFunctionTestRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('custom-function-tests').findBy 'id', params.custom_function_test_id
  actions:
    deleted: ->
      @transitionTo 'custom-function-tests'

`export default CustomFunctionTestRoute`
