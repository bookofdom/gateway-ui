`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

AnalyticsQueriesRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @store.findAll 'analytics-query'

  actions:
    selectQuery: (selection) ->
      query = @modelFor('analytics-queries').findBy 'type', selection
      @transitionTo 'analytics-query', query.get('type')

`export default AnalyticsQueriesRoute`
