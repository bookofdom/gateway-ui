`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

HostsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @modelFor('api').get 'hosts'

`export default HostsRoute`
