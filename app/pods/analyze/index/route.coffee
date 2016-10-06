`import Ember from 'ember'`

AnalyzeIndexRoute = Ember.Route.extend
  afterModel: -> @transitionTo 'stats-queries.index'

`export default AnalyzeIndexRoute`
