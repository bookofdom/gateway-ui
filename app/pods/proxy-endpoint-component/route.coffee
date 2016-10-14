`import Ember from 'ember'`

ProxyEndpointComponentRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('proxy-endpoint-components').findBy 'id', params.proxy_endpoint_component_id
  actions:
    deleted: ->
      @transitionTo 'proxy-endpoint'

`export default ProxyEndpointComponentRoute`
