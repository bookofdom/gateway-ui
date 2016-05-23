`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

AnalyticsQueriesRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @store.findAll 'analytics-query'

`export default AnalyticsQueriesRoute`
