`import Ember from 'ember'`


AnalyticsQueryRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('analytics-queries').findBy 'id', params.analytics_query_id

  actions:
    startChange: (date) ->
      @modelFor('analytics-query').set 'start', date
    endChange: (date) ->
      @modelFor('analytics-query').set 'end', date
    clear: ->
      @modelFor('analytics-query').setProperties
        start: null
        end: null

`export default AnalyticsQueryRoute`
