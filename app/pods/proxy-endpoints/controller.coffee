`import Ember from 'ember'`

ProxyEndpointsController = Ember.Controller.extend
  breadCrumb: 'resources.proxy-endpoint_plural'
  queryParams: ['environment_id', 'endpoint_group_id']

  api: Ember.inject.controller()
  'option-groups': Ember.computed 'api.environments.@each.isNew', 'api.endpoint_groups.@each.isNew', ->
    environment: @get('api.environments').filterBy 'isNew', false
    endpoint_group: @get('api.endpoint_groups').filterBy 'isNew', false

`export default ProxyEndpointsController`
