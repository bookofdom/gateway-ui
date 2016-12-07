`import EditController from 'gateway/pods/edit/controller'`

ProxyEndpointChannelEditController = EditController.extend
  'proxy-endpoint-channels': Ember.inject.controller()
  indexModel: Ember.computed.alias 'proxy-endpoint-channels.model'

  'api': Ember.inject.controller()
  remoteEndpoints: Ember.computed.alias 'api.model.remote_endpoints'

  'option-groups': Ember.computed 'remoteEndpoints.[]', ->
    'remote_endpoint': @get('remoteEndpoints')?.filterBy('isNew', false).filterBy 'type', 'push'

`export default ProxyEndpointChannelEditController`
