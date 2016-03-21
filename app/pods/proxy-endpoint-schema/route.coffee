`import Ember from 'ember'`


ProxyEndpointSchemaRoute = Ember.Route.extend 
  model: (params) ->
    @modelFor('proxy-endpoint-schemas').findBy 'id', params.proxy_endpoint_schema_id
  actions:
    deleted: ->
      @transitionTo 'proxy-endpoint-schemas'

`export default ProxyEndpointSchemaRoute`
