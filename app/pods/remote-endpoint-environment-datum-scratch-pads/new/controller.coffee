`import Ember from 'ember'`

RemoteEndpointEnvironmentDatumScratchPadsNewController = Ember.Controller.extend
  breadCrumb: 'actions.new'

  'remote-endpoint-environment-datum-scratch-pads': Ember.inject.controller()

  indexModel: Ember.computed.alias 'remote-endpoint-environment-datum-scratch-pads.model'

`export default RemoteEndpointEnvironmentDatumScratchPadsNewController`
