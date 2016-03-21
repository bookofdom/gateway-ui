`import Ember from 'ember'`

RemoteEndpointEnvironmentDatumScratchPadsRoute = Ember.Route.extend
  model: -> @modelFor('remote-endpoint-environment-datum').get 'scratch_pads'
  actions:
    saved: ->
      # no op (this action is for use by the new pad route)

`export default RemoteEndpointEnvironmentDatumScratchPadsRoute`
