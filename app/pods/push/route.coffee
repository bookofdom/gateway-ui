`import Ember from 'ember'`

PushRoute = Ember.Route.extend
  afterModel: ->
    Ember.RSVP.hash
      apis: @store.findAll 'api'
      remote_endpoints: @store.findAll 'remote-endpoint'
    .then (results) =>
      @set 'extraModels', results
  setupController: (controller) ->
    extraModels = @get 'extraModels'
    controller.setProperties extraModels
    @_super arguments...

`export default PushRoute`
