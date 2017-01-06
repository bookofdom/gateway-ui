`import Ember from 'ember'`

ProxyEndpointComponentCallRoute = Ember.Route.extend
  model: (params) ->
     @modelFor('proxy-endpoint-component-calls').findBy 'id', params.proxy_endpoint_component_call_id

`export default ProxyEndpointComponentCallRoute`
