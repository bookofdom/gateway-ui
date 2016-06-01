`import Ember from 'ember'`


AnalyticsQueryRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('analytics-queries').findBy 'id', params.analytics_query_id
  afterModel: ->
    @executeQuery()
  executeQuery: ->
    @modelFor('analytics-query').executeQuery()

  actions:
    startChange: (date) ->
      @modelFor('analytics-query').set 'start', date
      @executeQuery()
    endChange: (date) ->
      @modelFor('analytics-query').set 'end', date
      @executeQuery()
    clear: ->
      @modelFor('analytics-query').setProperties
        start: null
        end: null
      @executeQuery()

`export default AnalyticsQueryRoute`
