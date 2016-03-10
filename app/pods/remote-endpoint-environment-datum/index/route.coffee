`import Ember from 'ember'`


RemoteEndpointEnvironmentDatumIndexRoute = Ember.Route.extend 
  afterModel: -> @transitionTo 'remote-endpoint-environment-datum.edit'

`export default RemoteEndpointEnvironmentDatumIndexRoute`
