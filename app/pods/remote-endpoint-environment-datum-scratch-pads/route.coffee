`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

RemoteEndpointEnvironmentDatumScratchPadsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @modelFor('remote-endpoint-environment-datum').get 'scratch_pads'
  actions:
    saved: ->
      # no op (this action is for use by the new pad route)

`export default RemoteEndpointEnvironmentDatumScratchPadsRoute`
