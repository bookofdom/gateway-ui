`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

TimersRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @store.findAll 'timer'
  afterModel: ->
    Ember.RSVP.hash
      apis: @store.findAll 'api'
      environments: @store.findAll 'environment'
      endpoint_groups: @store.findAll 'endpoint_group'
      jobs: @store.findAll 'job'
    .then (results) =>
      @set 'extraModels', results
  setupController: (controller) ->
    extraModels = @get 'extraModels'
    controller.setProperties extraModels
    @_super arguments...

`export default TimersRoute`
