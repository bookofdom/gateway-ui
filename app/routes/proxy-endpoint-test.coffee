`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ProxyEndpointTestRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @modelFor('proxy-endpoint-tests').findBy 'id', params.proxy_endpoint_test_id
  actions:
    deleted: ->
      @transitionTo 'proxy-endpoint-tests'

`export default ProxyEndpointTestRoute`
