`import Ember from 'ember'`

RemoteEndpointEnvironmentDatumScratchPadsNewRoute = Ember.Route.extend
  actions:
    saved: ->
      @transitionTo 'remote-endpoint-environment-datum'

`export default RemoteEndpointEnvironmentDatumScratchPadsNewRoute`
