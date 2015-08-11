`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ProxyEndpointTestEditRoute = Ember.Route.extend AuthenticatedRouteMixin,
  actions:
    didTransition: ->
      @controller.reset()

`export default ProxyEndpointTestEditRoute`
