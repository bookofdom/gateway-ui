`import Ember from 'ember'`

StatsQueriesIndexRoute = Ember.Route.extend
  afterModel: ->
    statsQuery = @modelFor 'stats-queries'
      .filterBy 'isNew', false
      .filterBy 'isDeleted', false
      .get 'firstObject'
    @transitionTo 'stats-query', statsQuery

`export default StatsQueriesIndexRoute`
