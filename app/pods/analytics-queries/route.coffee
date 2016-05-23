`import Ember from 'ember'`

AnalyticsQueriesRoute = Ember.Route.extend
  model: -> @store.findAll 'analytics-query'

`export default AnalyticsQueriesRoute`
