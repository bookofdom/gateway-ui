`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

ProxyEndpointsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @modelFor('api').get 'proxy_endpoints'
  afterModel: ->
    Ember.RSVP.hash
      environments: @modelFor('api').get 'environments'
      endpoint_groups: @modelFor('api').get 'endpoint_groups'
    .then (results) =>
      @set 'extraModels', results
  setupController: (controller) ->
    extraModels = @get 'extraModels'
    controller.setProperties extraModels
    @_super.apply @, arguments

`export default ProxyEndpointsRoute`
