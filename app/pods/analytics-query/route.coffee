`import Ember from 'ember'`


AnalyticsQueryRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('analytics-queries').findBy 'id', params.analytics_query_id

`export default AnalyticsQueryRoute`
