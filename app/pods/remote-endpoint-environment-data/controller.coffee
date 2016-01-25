`import Ember from 'ember'`

RemoteEndpointEnvironmentDataController = Ember.Controller.extend
  breadCrumb: 'resources.remote-endpoint-environment-datum_plural'

  'api': Ember.inject.controller()
  'remote-endpoint': Ember.inject.controller()

  environments: Ember.computed.alias 'api.environments'
  remoteEndpointType: Ember.computed.alias 'remote-endpoint.model.type'

`export default RemoteEndpointEnvironmentDataController`
