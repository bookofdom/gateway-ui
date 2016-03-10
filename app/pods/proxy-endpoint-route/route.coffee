`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

ProxyEndpointRouteRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @modelFor('proxy-endpoint-routes').findBy 'id', params.proxy_endpoint_route_id

`export default ProxyEndpointRouteRoute`
