`import Ember from 'ember'`

RemoteEndpointPushPlatformsNewController = Ember.Controller.extend
  breadCrumb: 'actions.new'

  'remote-endpoint': Ember.inject.controller()

  remoteEndpointModel: Ember.computed.alias 'remote-endpoint.model'

`export default RemoteEndpointPushPlatformsNewController`
