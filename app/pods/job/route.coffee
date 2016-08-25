`import Ember from 'ember'`

JobRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('jobs').findBy 'id', params.job_id
  afterModel: ->
    # routes and components embedded records appear only when
    # loading individual proxy endpoints
    job = @modelFor 'job'
    job.cancel()
  actions:
    'proxy-endpoint-component-edit': (model) ->
      # no op
    deleted: ->
      @transitionTo 'jobs'

`export default JobRoute`
