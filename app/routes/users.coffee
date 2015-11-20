`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

UsersRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @store.findAll 'user'
  actions:
    refresh: -> @refresh()

`export default UsersRoute`
