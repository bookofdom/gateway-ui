`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

EndpointGroupRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @modelFor('endpoint-groups').findBy 'id', params.endpoint_group_id

`export default EndpointGroupRoute`
