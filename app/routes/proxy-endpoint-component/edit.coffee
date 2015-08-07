`import Ember from 'ember'`
`import EditRoute from '../edit'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ProxyEndpointComponentEditRoute = EditRoute.extend AuthenticatedRouteMixin

`export default ProxyEndpointComponentEditRoute`
