`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

RemoteEndpointEnvironmentDatumRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @modelFor('remote-endpoint-environment-data').findBy 'id', params.remote_endpoint_environment_datum_id

`export default RemoteEndpointEnvironmentDatumRoute`
