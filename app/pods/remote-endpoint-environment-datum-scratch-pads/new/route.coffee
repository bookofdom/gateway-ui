`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

RemoteEndpointEnvironmentDatumScratchPadsNewRoute = Ember.Route.extend AuthenticatedRouteMixin,
  actions:
    saved: ->
      @transitionTo 'remote-endpoint-environment-datum'

`export default RemoteEndpointEnvironmentDatumScratchPadsNewRoute`
