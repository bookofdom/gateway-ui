`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

ProxyEndpointSchemaIndexRoute = Ember.Route.extend AuthenticatedRouteMixin,
  afterModel: -> @transitionTo 'proxy-endpoint-schema.edit'

`export default ProxyEndpointSchemaIndexRoute`
