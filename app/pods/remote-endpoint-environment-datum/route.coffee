`import Ember from 'ember'`


RemoteEndpointEnvironmentDatumRoute = Ember.Route.extend 
  model: (params) ->
    @modelFor('remote-endpoint-environment-data').findBy 'id', params.remote_endpoint_environment_datum_id
  actions:
    saved: ->
      @transitionTo 'remote-endpoint'
    deleted: ->
      @transitionTo 'remote-endpoint'
    canceled: ->
      @transitionTo 'remote-endpoint'

`export default RemoteEndpointEnvironmentDatumRoute`
