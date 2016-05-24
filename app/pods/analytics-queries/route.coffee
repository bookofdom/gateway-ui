`import Ember from 'ember'`

AnalyticsQueriesRoute = Ember.Route.extend
  model: -> @store.findAll 'analytics-query'
  afterModel: ->
    query = @modelFor('analytics-queries').get 'firstObject'
    @transitionTo 'analytics-query', query.get('type')
  renderTemplate: ->
    @_super arguments...
    @render 'analytics-queries/sidebar',
      outlet: 'sidebar'
      into: 'analytics-queries'

  actions:
    selectQuery: (selection) ->
      query = @modelFor('analytics-queries').findBy 'type', selection
      @transitionTo 'analytics-query', query.get('type')

`export default AnalyticsQueriesRoute`
