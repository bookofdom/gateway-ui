`import Ember from 'ember'`

AnalyticsQueriesIndexRoute = Ember.Route.extend
  afterModel: ->
    query = @modelFor('analytics-queries').get 'firstObject'
    @transitionTo 'analytics-query', query

`export default AnalyticsQueriesIndexRoute`
