`import Ember from 'ember'`

JobsRoute = Ember.Route.extend
  queryParams:
    environment_id:
      refreshModel: false
    endpoint_group_id:
      refreshModel: false

  model: -> @modelFor('api').get 'jobs'

`export default JobsRoute`
