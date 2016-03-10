`import Ember from 'ember'`


ProxyEndpointComponentCallsRoute = Ember.Route.extend 
  model: -> @modelFor('proxy-endpoint-component').get 'calls'

`export default ProxyEndpointComponentCallsRoute`
