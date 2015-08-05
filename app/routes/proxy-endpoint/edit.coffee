`import Ember from 'ember'`
`import EditRoute from '../edit'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ProxyEndpointEditRoute = EditRoute.extend AuthenticatedRouteMixin

`export default ProxyEndpointEditRoute`
