`import Ember from 'ember'`

UsersRoute = Ember.Route.extend
  model: -> @store.findAll 'user'
  actions:
    refresh: -> @refresh()

`export default UsersRoute`
