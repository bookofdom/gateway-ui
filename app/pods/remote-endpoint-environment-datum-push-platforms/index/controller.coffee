`import Ember from 'ember'`

RemoteEndpointEnvironmentDatumPushPlatformsIndexController = Ember.Controller.extend

  'remote-endpoint': Ember.inject.controller()
  'remote-endpoint-environment-datum': Ember.inject.controller()

  remoteEndpointModel: Ember.computed.alias 'remote-endpoint.model'
  environmentDatumModel: Ember.computed.alias 'remote-endpoint-environment-datum.model'

`export default RemoteEndpointEnvironmentDatumPushPlatformsIndexController`
