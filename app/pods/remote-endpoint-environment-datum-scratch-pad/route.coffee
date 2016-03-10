`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

RemoteEndpointEnvironmentDatumScratchPadRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @modelFor('remote-endpoint-environment-datum-scratch-pads').findBy 'id', params.scratch_pad_id
  actions:
    deleted: ->
      @transitionTo 'remote-endpoint-environment-datum'
    canceled: ->
      @transitionTo 'remote-endpoint-environment-datum'

`export default RemoteEndpointEnvironmentDatumScratchPadRoute`
