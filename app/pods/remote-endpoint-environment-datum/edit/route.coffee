`import Ember from 'ember'`
`import EditRoute from 'gateway/pods/edit/route'`


RemoteEndpointEnvironmentDatumEditRoute = EditRoute.extend
  actions:
    # Disable the abandon confirm message for this resource.
    # TODO this can be fixed in the future when environment data are no
    # longer anonymous.
    willTransition: (transition) ->
      if @currentModel.get 'hasDirtyAttributes'
        @currentModel.cancel()
        true
    'new-remote-endpoint-push-platform': ->
      @transitionTo 'remote-endpoint-environment-datum-push-platforms.new'

`export default RemoteEndpointEnvironmentDatumEditRoute`
