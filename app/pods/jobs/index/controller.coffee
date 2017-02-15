`import Ember from 'ember'`

JobsIndexController = Ember.Controller.extend
  api: Ember.inject.controller()
  'jobs': Ember.inject.controller()

  'option-groups': Ember.computed.alias 'jobs.option-groups'

  environments: Ember.computed.alias 'api.environments'
  endpoint_groups: Ember.computed.alias 'api.endpoint_groups'

  fields: [
    name: 'name'
    label: 'fields.name'
    type: 'string'
  ,
    name: 'environment.name'
    label: 'resources.environment'
    type: 'string'
  ,
    name: 'endpoint_group.name'
    label: 'resources.endpoint-group'
    type: 'string'
  ]

`export default JobsIndexController`
