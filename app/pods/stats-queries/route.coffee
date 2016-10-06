`import Ember from 'ember'`

StatsQueriesRoute = Ember.Route.extend
  model: -> @store.findAll 'stats-query'

`export default StatsQueriesRoute`
