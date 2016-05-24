`import Ember from 'ember'`

AnalyticsQueriesRoute = Ember.Route.extend
  model: -> @store.findAll 'analytics-query'
  renderTemplate: ->
    @_super arguments...
    @render 'analytics-queries/sidebar',
      outlet: 'sidebar'
      into: 'analytics-queries'

`export default AnalyticsQueriesRoute`
