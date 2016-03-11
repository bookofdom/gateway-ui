`import Ember from 'ember'`


EndpointGroupRoute = Ember.Route.extend 
  model: (params) ->
    @modelFor('endpoint-groups').findBy 'id', params.endpoint_group_id
  actions:
    deleted: ->
      @transitionTo 'endpoint-groups'

`export default EndpointGroupRoute`
