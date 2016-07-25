`import Ember from 'ember'`

RemoteEndpointPushPlatformsIndexController = Ember.Controller.extend

  'remote-endpoint': Ember.inject.controller()

  remoteEndpointModel: Ember.computed.alias 'remote-endpoint.model'

`export default RemoteEndpointPushPlatformsIndexController`
