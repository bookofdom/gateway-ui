`import Ember from 'ember'`

JobsRoute = Ember.Route.extend
  model: -> @modelFor('api').get 'jobs'

  actions:
    saved: (model) ->
      @transitionTo 'job', model

`export default JobsRoute`
