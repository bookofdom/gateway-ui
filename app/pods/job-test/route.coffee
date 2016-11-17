`import Ember from 'ember'`

JobTestRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('job-tests').findBy 'id', params.job_test_id
  actions:
    deleted: ->
      @transitionTo 'job-tests'

`export default JobTestRoute`
