`import Ember from 'ember'`
`import EditRoute from 'gateway/routes/edit'`


RemoteEndpointEditRoute = EditRoute.extend 
  actions:
    'new-remote-endpoint-environment-datum': ->
      @transitionTo 'remote-endpoint-environment-data.new'

`export default RemoteEndpointEditRoute`
