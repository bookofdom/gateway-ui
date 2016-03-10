`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

RemoteEndpointEnvironmentDatumRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @modelFor('remote-endpoint-environment-data').findBy 'id', params.remote_endpoint_environment_datum_id
  actions:
    saved: ->
      @transitionTo 'remote-endpoint'
    deleted: ->
      @transitionTo 'remote-endpoint'
    canceled: ->
      @transitionTo 'remote-endpoint'

`export default RemoteEndpointEnvironmentDatumRoute`
