`import Ember from 'ember'`

RemoteEndpointEnvironmentDatumPushPlatformsIndexController = Ember.Controller.extend

  'remote-endpoint-environment-datum': Ember.inject.controller()

  parentModel: Ember.computed.alias 'remote-endpoint-environment-datum.model'

`export default RemoteEndpointEnvironmentDatumPushPlatformsIndexController`
