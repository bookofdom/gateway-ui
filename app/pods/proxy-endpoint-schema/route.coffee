`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ProxyEndpointSchemaRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @modelFor('proxy-endpoint-schemas').findBy 'id', params.proxy_endpoint_schema_id
  actions:
    deleted: ->
      @transitionTo 'proxy-endpoint-schemas'

`export default ProxyEndpointSchemaRoute`
