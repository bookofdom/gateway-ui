`import Ember from 'ember'`

CustomFunctionRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('custom-functions').findBy 'id', params.custom_function_id
  actions:
    deleted: ->
      @transitionTo 'custom-functions'

`export default CustomFunctionRoute`
