`import Ember from 'ember'`

RemoteEndpointEnvironmentDataIndexController = Ember.Controller.extend
  'api': Ember.inject.controller()
  'remote-endpoint': Ember.inject.controller()

  environments: Ember.computed.alias 'api.environments'
  remoteEndpointType: Ember.computed.alias 'remote-endpoint.model.type'

`export default RemoteEndpointEnvironmentDataIndexController`
