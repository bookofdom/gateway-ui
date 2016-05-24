`import Ember from 'ember'`

AnalyzeIndexRoute = Ember.Route.extend
  afterModel: -> @transitionTo 'analytics-queries'

`export default AnalyzeIndexRoute`
