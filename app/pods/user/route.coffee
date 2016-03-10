`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

UserRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) -> @modelFor('users').findBy 'id', params.user_id
  actions:
    deleted: ->
      @transitionTo 'users'

`export default UserRoute`
