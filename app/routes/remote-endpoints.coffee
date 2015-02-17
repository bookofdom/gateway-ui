`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

RemoteEndpointsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @modelFor('api').get 'remote_endpoints'
  afterModel: ->
    Ember.RSVP.hash
      environments: @modelFor('api').get 'environments'
    .then (results) =>
      @set 'extraModels', results
  setupController: (controller) ->
    extraModels = @get 'extraModels'
    controller.setProperties extraModels
    @_super.apply @, arguments

`export default RemoteEndpointsRoute`
