`import Ember from 'ember'`


RemoteEndpointRoute = Ember.Route.extend 
  model: (params) ->
    @modelFor('remote-endpoints').findBy 'id', params.remote_endpoint_id
  actions:
    deleted: ->
      @transitionTo 'remote-endpoints'

`export default RemoteEndpointRoute`
