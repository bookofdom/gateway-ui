`import Ember from 'ember'`

RemoteEndpointEnvironmentDatumScratchPadsIndexController = Ember.Controller.extend
  'remote-endpoint-environment-datum-scratch-pads': Ember.inject.controller()

  indexModel: Ember.computed.alias 'remote-endpoint-environment-datum-scratch-pads.model'

`export default RemoteEndpointEnvironmentDatumScratchPadsIndexController`
