`import Ember from 'ember'`

JobsRoute = Ember.Route.extend
  queryParams:
    environment_id:
      refreshModel: false
    endpoint_group_id:
      refreshModel: false

  model: -> @modelFor('api').get 'jobs'

  actions:
    saved: (model) ->
      console.log("here")
      @transitionTo 'job', model

`export default JobsRoute`
