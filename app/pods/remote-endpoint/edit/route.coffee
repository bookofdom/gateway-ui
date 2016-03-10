`import Ember from 'ember'`
`import EditRoute from 'gateway/routes/edit'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

RemoteEndpointEditRoute = EditRoute.extend AuthenticatedRouteMixin,
  actions:
    'new-remote-endpoint-environment-datum': ->
      @transitionTo 'remote-endpoint-environment-data.new'

`export default RemoteEndpointEditRoute`
