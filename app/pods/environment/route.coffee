`import Ember from 'ember'`


EnvironmentRoute = Ember.Route.extend 
  model: (params) ->
    @modelFor('environments').findBy 'id', params.environment_id
  actions:
    deleted: ->
      @transitionTo 'environments'

`export default EnvironmentRoute`
