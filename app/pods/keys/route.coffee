`import Ember from 'ember'`

KeysRoute = Ember.Route.extend
  model: -> @store.findAll 'key'
  renderTemplate: ->
    @_super arguments...
    @render 'admin/secondary-sidebar',
      outlet: 'sidebar'
      into: 'keys'

`export default KeysRoute`
