`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

ProxyEndpointComponentCallRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @modelFor('proxy-endpoint-component-calls').findBy 'id', params.proxy_endpoint_component_call_id

`export default ProxyEndpointComponentCallRoute`
