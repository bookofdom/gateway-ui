`import Ember from 'ember'`

UsersRoute = Ember.Route.extend
  model: -> @store.findAll 'user'
  renderTemplate: ->
    @_super arguments...
    @render 'admin/secondary-sidebar',
      outlet: 'sidebar'
      into: 'users'
  actions:
    refresh: -> @refresh()

`export default UsersRoute`
