`import Ember from 'ember'`
`import EditRoute from '../edit'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

RemoteEndpointEnvironmentDatumEditRoute = EditRoute.extend AuthenticatedRouteMixin,
  actions:
    # Disable the abandon confirm message for this resource.
    # TODO this can be fixed in the future when environment data are no
    # longer anonymous.
    willTransition: (transition) ->
      if @currentModel.get 'hasDirtyAttributes'
        @currentModel.cancel()
        true

`export default RemoteEndpointEnvironmentDatumEditRoute`
