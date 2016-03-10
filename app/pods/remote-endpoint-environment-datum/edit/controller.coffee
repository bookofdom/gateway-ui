`import EditController from 'gateway/controllers/edit'`

RemoteEndpointEnvironmentDatumEditController = EditController.extend
  'remote-endpoint-environment-data': Ember.inject.controller()

  indexModel: Ember.computed.alias 'remote-endpoint-environment-data.model'
  environments: Ember.computed.alias 'remote-endpoint-environment-data.environments'
  remoteEndpointType: Ember.computed.alias 'remote-endpoint-environment-data.remoteEndpointType'

  actions:
    'new-remote-endpoint-environment-datum-scratch-pad': ->
      @transitionToRoute 'remote-endpoint-environment-datum-scratch-pads.new'

`export default RemoteEndpointEnvironmentDatumEditController`
