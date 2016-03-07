`import Ember from 'ember'`
`import EditRoute from 'gateway/routes/edit'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

RemoteEndpointEnvironmentDatumScratchPadEditRoute = EditRoute.extend AuthenticatedRouteMixin,
  actions:
    didTransition: ->
      @controller.reset()
      true

`export default RemoteEndpointEnvironmentDatumScratchPadEditRoute`
