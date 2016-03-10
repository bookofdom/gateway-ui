`import Ember from 'ember'`


ProxyEndpointIndexRoute = Ember.Route.extend 
  afterModel: -> @transitionTo 'proxy-endpoint.edit'

`export default ProxyEndpointIndexRoute`
