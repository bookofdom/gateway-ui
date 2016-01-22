`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

RemoteEndpointRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @modelFor('remote-endpoints').findBy 'id', params.remote_endpoint_id
  actions:
    deleted: ->
      @transitionTo 'remote-endpoints'

`export default RemoteEndpointRoute`
