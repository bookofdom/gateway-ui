`import Ember from 'ember'`


UserIndexRoute = Ember.Route.extend 
  afterModel: -> @transitionTo 'user.edit'

`export default UserIndexRoute`
