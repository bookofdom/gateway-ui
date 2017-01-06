`import Ember from 'ember'`

JobComponentCallRoute = Ember.Route.extend
  model: (params) ->
     @modelFor('job-component-calls').findBy 'id', params.job_component_call_id

`export default JobComponentCallRoute`
