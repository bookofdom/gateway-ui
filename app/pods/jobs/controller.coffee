`import Ember from 'ember'`

JobsController = Ember.Controller.extend
  breadCrumb: 'resources.job_plural'
  
  api: Ember.inject.controller()
  'option-groups': Ember.computed 'api.environments.@each.isNew', 'api.endpoint_groups.@each.isNew', ->
    environment: @get('api.environments').filterBy 'isNew', false
    endpoint_group: @get('api.endpoint_groups').filterBy 'isNew', false

`export default JobsController`
