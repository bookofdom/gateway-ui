`import Ember from 'ember'`


ProxyEndpointSchemaIndexRoute = Ember.Route.extend 
  afterModel: -> @transitionTo 'proxy-endpoint-schema.edit'

`export default ProxyEndpointSchemaIndexRoute`
