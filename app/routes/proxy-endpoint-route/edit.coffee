`import Ember from 'ember'`
`import EditRoute from '../edit'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ProxyEndpointRouteEditRoute = EditRoute.extend AuthenticatedRouteMixin

`export default ProxyEndpointRouteEditRoute`
