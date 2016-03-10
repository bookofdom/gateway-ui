`import Ember from 'ember'`


ProxyEndpointRouteRoute = Ember.Route.extend 
  model: (params) ->
    @modelFor('proxy-endpoint-routes').findBy 'id', params.proxy_endpoint_route_id

`export default ProxyEndpointRouteRoute`
