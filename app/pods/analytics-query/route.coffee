`import Ember from 'ember'`


AnalyticsQueryRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('analytics-queries').findBy 'type', params.analytics_query_type
  queryParams:
    start:
      refreshModel: false
    end:
      refreshModel: false

`export default AnalyticsQueryRoute`
