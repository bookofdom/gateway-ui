`import Ember from 'ember'`

PushDevicesRoute = Ember.Route.extend
  model: -> @store.findAll 'push-device'
  afterModel: ->
    Ember.RSVP.hash
      remote_endpoints: @store.findAll 'remote-endpoint'
    .then (results) =>
      @set 'extraModels', results
  setupController: (controller) ->
    extraModels = @get 'extraModels'
    controller.setProperties extraModels
    @_super arguments...
  renderTemplate: ->
    @_super arguments...
    @render 'push/secondary-sidebar',
      outlet: 'sidebar'
      into: 'push-devices'

`export default PushDevicesRoute`
