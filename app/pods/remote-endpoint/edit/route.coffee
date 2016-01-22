`import Ember from 'ember'`
`import EditRoute from 'gateway/routes/edit'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

RemoteEndpointEditRoute = EditRoute.extend AuthenticatedRouteMixin

`export default RemoteEndpointEditRoute`
