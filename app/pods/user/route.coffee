`import Ember from 'ember'`


UserRoute = Ember.Route.extend 
  model: (params) -> @modelFor('users').findBy 'id', params.user_id
  actions:
    deleted: ->
      @transitionTo 'users'

`export default UserRoute`
