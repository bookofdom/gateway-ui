`import Ember from 'ember'`


RemoteEndpointIndexRoute = Ember.Route.extend 
  afterModel: -> @transitionTo 'remote-endpoint.edit'

`export default RemoteEndpointIndexRoute`
