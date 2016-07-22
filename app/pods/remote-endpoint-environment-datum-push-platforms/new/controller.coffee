`import Ember from 'ember'`

RemoteEndpointEnvironmentDatumPushPlatformsNewController = Ember.Controller.extend
  breadCrumb: 'actions.new'

  'remote-endpoint': Ember.inject.controller()
  'remote-endpoint-environment-datum': Ember.inject.controller()

  remoteEndpointModel: Ember.computed.alias 'remote-endpoint.model'
  environmentDatumModel: Ember.computed.alias 'remote-endpoint-environment-datum.model'

`export default RemoteEndpointEnvironmentDatumPushPlatformsNewController`
