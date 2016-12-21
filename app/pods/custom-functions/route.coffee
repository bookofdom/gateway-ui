`import Ember from 'ember'`

CustomFunctionsRoute = Ember.Route.extend
  model: -> @modelFor('api').get 'custom_functions'

  actions:
    saved: (model) ->
      @transitionTo 'custom-function', model

`export default CustomFunctionsRoute`
