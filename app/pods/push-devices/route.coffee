`import Ember from 'ember'`

PushDevicesRoute = Ember.Route.extend
  model: -> @store.findAll 'push-device'
  renderTemplate: ->
    @_super arguments...
    @render 'push/secondary-sidebar',
      outlet: 'sidebar'
      into: 'push-devices'

`export default PushDevicesRoute`
