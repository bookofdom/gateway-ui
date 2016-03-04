`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ScratchPadsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @modelFor('remote-endpoint-environment-datum').get 'scratch_pads'
  actions:
    saved: ->
      # no op (this action is for use by the new pad route)

`export default ScratchPadsRoute`
