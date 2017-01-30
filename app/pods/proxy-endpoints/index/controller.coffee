`import Ember from 'ember'`
`import t from 'gateway-ui/helpers/i18n'`

ProxyEndpointsIndexController = Ember.Controller.extend
  api: Ember.inject.controller()
  'proxy-endpoints': Ember.inject.controller()

  'option-groups': Ember.computed.alias 'proxy-endpoints.option-groups'

  environments: Ember.computed.alias 'api.environments'
  endpoint_groups: Ember.computed.alias 'api.endpoint_groups'

  labels: Ember.computed 'environments', 'endpoint_groups', 'proxy-endpoints.environment_id', 'proxy-endpoints.endpoint_group_id', ->
    environment_id = @get 'proxy-endpoints.environment_id'
    endpoint_group_id = @get 'proxy-endpoints.endpoint_group_id'
    environment = @get('environments')?.findBy 'id', environment_id
    endpoint_group = @get('endpoint_groups')?.findBy 'id', endpoint_group_id
    environment: if environment? then environment.get 'name' else t 'prompts.choose-x', x: 'resources.environment'
    endpoint_group: if endpoint_group? then endpoint_group.get 'name' else t 'prompts.choose-x', x: 'resources.endpoint-group'

  # 'name,description,environment:resources.environment:object-name,endpoint_group:resources.endpoint-group:object-name,active::active-label'
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
  ,
    name: 'active'
    label: 'fields.active'
    type: 'active-label'
  ]

`export default ProxyEndpointsIndexController`
