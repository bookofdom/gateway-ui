`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

ProxyEndpointComponentRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @modelFor('proxy-endpoint-components').findBy 'id', params.proxy_endpoint_component_id
  actions:
    deleted: ->
      @transitionTo 'proxy-endpoint'

`export default ProxyEndpointComponentRoute`
