`import Ember from 'ember'`

RemoteEndpointEnvironmentDatumScratchPadRoute = Ember.Route.extend
  model: (params) ->
    @modelFor('remote-endpoint-environment-datum-scratch-pads').findBy 'id', params.scratch_pad_id
  actions:
    deleted: ->
      @transitionTo 'remote-endpoint-environment-datum'
    canceled: ->
      @transitionTo 'remote-endpoint-environment-datum'

`export default RemoteEndpointEnvironmentDatumScratchPadRoute`
