`import Ember from 'ember'`
`import EditRoute from '../edit'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

EnvironmentEditRoute = EditRoute.extend AuthenticatedRouteMixin

`export default EnvironmentEditRoute`
