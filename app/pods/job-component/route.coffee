`import Ember from 'ember'`

JobComponentRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('job-components').findBy 'id', params.job_component_id
  actions:
    deleted: ->
      @transitionTo 'job'

`export default JobComponentRoute`
