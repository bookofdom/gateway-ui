`import Ember from 'ember'`
`import EditRoute from 'gateway/routes/edit'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SharedComponentCallEditRoute = EditRoute.extend AuthenticatedRouteMixin

`export default SharedComponentCallEditRoute`
