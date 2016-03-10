`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

ProxyEndpointTestEditRoute = Ember.Route.extend AuthenticatedRouteMixin,
  actions:
    didTransition: ->
      @controller.reset()
      true

`export default ProxyEndpointTestEditRoute`
