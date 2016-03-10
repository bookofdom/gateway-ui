`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

EndpointGroupIndexRoute = Ember.Route.extend AuthenticatedRouteMixin,
  afterModel: -> @transitionTo 'endpoint-group.edit'

`export default EndpointGroupIndexRoute`
