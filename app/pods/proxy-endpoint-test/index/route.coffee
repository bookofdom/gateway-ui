`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

ProxyEndpointTestIndexRoute = Ember.Route.extend AuthenticatedRouteMixin,
  afterModel: -> @transitionTo 'proxy-endpoint-test.edit'

`export default ProxyEndpointTestIndexRoute`
