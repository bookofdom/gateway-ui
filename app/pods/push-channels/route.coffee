`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

PushChannelsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @store.findAll 'push-channel'
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
  renderTemplate: ->
    @_super arguments...
    @render 'manage/secondary-sidebar',
      outlet: 'sidebar'
      into: 'push-channels'
  actions:
    refresh: -> @refresh()

`export default PushChannelsRoute`
