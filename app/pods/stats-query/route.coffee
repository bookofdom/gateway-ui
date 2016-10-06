`import Ember from 'ember'`

StatsQueryRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('stats-queries').findBy 'id', params.stats_query_id
  afterModel: ->
    @executeQuery()
  executeQuery: ->
    @modelFor('stats-query').executeQuery()

`export default StatsQueryRoute`
