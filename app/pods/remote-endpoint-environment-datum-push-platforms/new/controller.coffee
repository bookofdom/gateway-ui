`import Ember from 'ember'`

RemoteEndpointEnvironmentDatumPushPlatformsNewController = Ember.Controller.extend
  breadCrumb: 'actions.new'

  'api': Ember.inject.controller()
  'remote-endpoint': Ember.inject.controller()

  apiModel: Ember.computed.alias 'api.model'
  remoteEndpointModel: Ember.computed.alias 'remote-endpoint.model'

`export default RemoteEndpointEnvironmentDatumPushPlatformsNewController`
