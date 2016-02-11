`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ScratchPadRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @modelFor('scratch-pads').findBy 'id', params.scratch_pad_id
  actions:
    deleted: ->
      @transitionTo 'remote-endpoint-environment-datum'
    canceled: ->
      @transitionTo 'remote-endpoint-environment-datum'

`export default ScratchPadRoute`
