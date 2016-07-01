`import Ember from 'ember'`

PushRoute = Ember.Route.extend
  renderTemplate: ->
    @_super arguments...
    @render 'manage/secondary-sidebar',
      outlet: 'sidebar'
      into: 'push'

`export default PushRoute`
