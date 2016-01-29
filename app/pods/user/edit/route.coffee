`import Ember from 'ember'`
`import EditRoute from 'gateway/routes/edit'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

UserEditRoute = EditRoute.extend AuthenticatedRouteMixin

`export default UserEditRoute`
