`import Ember from 'ember'`

ProxyEndpointsController = Ember.Controller.extend
  breadCrumb: 'resources.proxy-endpoint_plural'

  api: Ember.inject.controller()
  'option-groups': Ember.computed 'api.environments.@each.isNew', 'api.endpoint_groups.@each.isNew', 'api.remote_endpoints.@each.isNew', ->
    environment: @get('api.environments').filterBy 'isNew', false
    endpoint_group: @get('api.endpoint_groups').filterBy 'isNew', false
    remote_endpoint: @get('api.remote_endpoints')?.filterBy('isNew', false).filterBy 'type', 'push'

`export default ProxyEndpointsController`
