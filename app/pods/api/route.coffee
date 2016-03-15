`import Ember from 'ember'`


ApiRoute = Ember.Route.extend
  model: (params) -> @modelFor('apis').findBy 'id', params.api_id
  afterModel: ->
    Ember.RSVP.hash
      endpoint_groups: @modelFor('api').get 'endpoint_groups'
      environments: @modelFor('api').get 'environments'
      libraries: @modelFor('api').get 'libraries'
      remote_endpoints: @modelFor('api').get 'remote_endpoints'
    .then (results) =>
      @set 'extraModels', results
  setupController: (controller) ->
    extraModels = @get 'extraModels'
    controller.setProperties extraModels
    @_super arguments...
  renderTemplate: ->
    @_super arguments...
    @render 'api/sidebar',
      outlet: 'sidebar'
      into: 'api'
  actions:
    deleted: ->
      @transitionTo 'apis'

`export default ApiRoute`
