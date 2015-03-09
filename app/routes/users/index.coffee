`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

UsersIndexRoute = Ember.Route.extend AuthenticatedRouteMixin,
  afterModel: ->
    firstUser = @modelFor('users').get 'firstObject'
    @transitionTo 'user', firstUser if firstUser

`export default UsersIndexRoute`
