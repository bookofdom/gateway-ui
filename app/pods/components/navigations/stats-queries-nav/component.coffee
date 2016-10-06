`import Ember from 'ember'`

StatsQueriesNavComponent = Ember.Component.extend
  data: null
  stats_queries: Ember.computed.alias 'data'

`export default StatsQueriesNavComponent`
