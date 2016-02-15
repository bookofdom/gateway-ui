`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ProxyEndpointRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @modelFor('proxy-endpoints').findBy 'id', params.proxy_endpoint_id
  afterModel: ->
    # routes and components embedded records appear only when
    # loading individual proxy endpoints
    proxyEndpoint = @modelFor 'proxy-endpoint'
    proxyEndpoint.cancel()
  actions:
    'proxy-endpoint-component-edit': (model) ->
      # no op
      # https://github.com/AnyPresence/gateway-ui/pull/158
    deleted: ->
      @transitionTo 'proxy-endpoints'

`export default ProxyEndpointRoute`
