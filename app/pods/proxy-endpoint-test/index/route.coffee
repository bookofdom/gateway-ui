`import Ember from 'ember'`


ProxyEndpointTestIndexRoute = Ember.Route.extend 
  afterModel: -> @transitionTo 'proxy-endpoint-test.edit'

`export default ProxyEndpointTestIndexRoute`
