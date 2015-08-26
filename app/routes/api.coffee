`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ApiRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) -> @modelFor('apis').findBy 'id', params.api_id
  afterModel: ->
    Ember.RSVP.hash
      environments: @modelFor('api').get 'environments'
      endpoint_groups: @modelFor('api').get 'endpoint_groups'
      remote_endpoints: @modelFor('api').get 'remote_endpoints'
    .then (results) =>
      @set 'extraModels', results
  setupController: (controller) ->
    extraModels = @get 'extraModels'
    controller.setProperties extraModels
    @_super.apply @, arguments
  actions:
    deleted: ->
      @transitionTo 'apis'

`export default ApiRoute`
