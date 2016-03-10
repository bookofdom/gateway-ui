`import Ember from 'ember'`
`import EditRoute from 'gateway/routes/edit'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

ProxyEndpointRouteEditRoute = EditRoute.extend AuthenticatedRouteMixin

`export default ProxyEndpointRouteEditRoute`
