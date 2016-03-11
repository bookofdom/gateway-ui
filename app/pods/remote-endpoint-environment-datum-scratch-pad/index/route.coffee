`import Ember from 'ember'`

RemoteEndpointEnvironmentDatumScratchPadIndexRoute = Ember.Route.extend
  afterModel: -> @transitionTo 'remote-endpoint-environment-datum-scratch-pad.edit'

`export default RemoteEndpointEnvironmentDatumScratchPadIndexRoute`
