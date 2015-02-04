`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ProxyEndpointRoutesRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @modelFor('proxy-endpoint').get 'routes'

`export default ProxyEndpointRoutesRoute`
