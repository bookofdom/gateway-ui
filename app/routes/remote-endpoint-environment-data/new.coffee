`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

RemoteEndpointEnvironmentDataNewRoute = Ember.Route.extend AuthenticatedRouteMixin,
  actions:
    saved: ->
      model = @modelFor('remote-endpoint')
      # transition up and then down because :(
      @transitionTo('remote-endpoints').then =>
        @transitionTo 'remote-endpoint.edit', model

`export default RemoteEndpointEnvironmentDataNewRoute`
