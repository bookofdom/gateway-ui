`import Ember from 'ember'`

ProxyEndpointChannelsIndexController = Ember.Controller.extend
  'api': Ember.inject.controller()
  remoteEndpoints: Ember.computed.alias 'api.model.remote_endpoints'

  'option-groups': Ember.computed 'remoteEndpoints.[]', ->
    'remote_endpoint': @get('remoteEndpoints')?.filterBy('isNew', false).filterBy 'type', 'push'

  fields: [
    name: 'name'
    label: 'fields.name'
    type: 'string'
  ,
    name: 'remote_endpoint.name'
    label: 'resources.remote-endpoint'
    type: 'string'
  ]

`export default ProxyEndpointChannelsIndexController`
