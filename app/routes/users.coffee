`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

UsersRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @store.find 'user'

`export default UsersRoute`
