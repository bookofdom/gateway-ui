`import Ember from 'ember'`


AnalyticsQueryRoute = Ember.Route.extend
  queryParams:
    start:
      refreshModel: false
    end:
      refreshModel: false
  model: (params) ->
    @modelFor('analytics-queries').findBy 'id', params.analytics_query_id

`export default AnalyticsQueryRoute`
