`import Ember from 'ember'`

CustomFunctionFileRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('custom-function-files').findBy 'id', params.custom_function_file_id
  actions:
    deleted: ->
      @transitionTo 'custom-function-files'

`export default CustomFunctionFileRoute`
