`import Ember from 'ember'`


AnalyticsQueryRoute = Ember.Route.extend
  queryParams:
    start:
      refreshModel: false
    end:
      refreshModel: false
  model: (params) ->
    @modelFor('analytics-queries').findBy 'type', params.analytics_query_type

`export default AnalyticsQueryRoute`
