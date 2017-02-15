`import Ember from 'ember'`

ProxyEndpointsIndexController = Ember.Controller.extend
  api: Ember.inject.controller()
  'proxy-endpoints': Ember.inject.controller()

  'option-groups': Ember.computed.alias 'proxy-endpoints.option-groups'

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
  ,
    name: 'active'
    label: 'fields.active'
    type: 'active-label'
  ]

`export default ProxyEndpointsIndexController`
