`import Ember from 'ember'`

ProxyEndpointChannelsIndexController = Ember.Controller.extend
  'api': Ember.inject.controller()
  remoteEndpoints: Ember.computed.alias 'api.model.remote_endpoints'

  'option-groups': Ember.computed 'remoteEndpoints.[]', ->
    'remote_endpoint': @get('remoteEndpoints')?.filterBy('isNew', false).filterBy 'type', 'push'

`export default ProxyEndpointChannelsIndexController`
