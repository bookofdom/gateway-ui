`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

RemoteEndpointEnvironmentDatumScratchPadIndexRoute = Ember.Route.extend AuthenticatedRouteMixin,
  afterModel: -> @transitionTo 'remote-endpoint-environment-datum-scratch-pad.edit'

`export default RemoteEndpointEnvironmentDatumScratchPadIndexRoute`
