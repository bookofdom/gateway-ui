`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

LogsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @store.createRecord 'log'

`export default LogsRoute`
