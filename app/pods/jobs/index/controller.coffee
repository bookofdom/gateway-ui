`import Ember from 'ember'`
`import t from 'gateway-ui/helpers/i18n'`

JobsIndexController = Ember.Controller.extend
  api: Ember.inject.controller()
  'jobs': Ember.inject.controller()

  'option-groups': Ember.computed.alias 'jobs.option-groups'

  environments: Ember.computed.alias 'api.environments'
  endpoint_groups: Ember.computed.alias 'api.endpoint_groups'

  labels: Ember.computed 'environments', 'endpoint_groups', 'jobs.environment_id', 'jobs.endpoint_group_id', ->
    environment_id = @get 'jobs.environment_id'
    endpoint_group_id = @get 'jobs.endpoint_group_id'
    environment = @get('environments')?.findBy 'id', environment_id
    endpoint_group = @get('endpoint_groups')?.findBy 'id', endpoint_group_id
    environment: if environment? then environment.get 'name' else t 'prompts.choose-x', x: 'resources.environment'
    endpoint_group: if endpoint_group? then endpoint_group.get 'name' else t 'prompts.choose-x', x: 'resources.endpoint-group'

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
