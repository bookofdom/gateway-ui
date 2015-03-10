`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

UserRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) -> @modelFor('users').findBy 'id', params.user_id

`export default UserRoute`
