`import Ember from 'ember'`
`import EditRoute from 'gateway/pods/edit/route'`


RemoteEndpointEditRoute = EditRoute.extend
  actions:
    'new-remote-endpoint-environment-datum': ->
      @transitionTo 'remote-endpoint-environment-data.new'
    'new-remote-endpoint-push-platform': ->
      @transitionTo 'remote-endpoint-push-platforms.new'

`export default RemoteEndpointEditRoute`
