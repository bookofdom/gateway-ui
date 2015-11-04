`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ProxyEndpointsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  queryParams:
    environment_id:
      refreshModel: false

  model: -> @modelFor('api').get 'proxy_endpoints'

`export default ProxyEndpointsRoute`
