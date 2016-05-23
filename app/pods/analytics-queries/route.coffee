`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

ApisRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @store.findAll 'analytics-query'

`export default ApisRoute`
