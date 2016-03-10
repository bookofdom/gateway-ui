`import Ember from 'ember'`


ProxyEndpointComponentCallIndexRoute = Ember.Route.extend 
  afterModel: -> @transitionTo 'proxy-endpoint-component-call.edit'

`export default ProxyEndpointComponentCallIndexRoute`
