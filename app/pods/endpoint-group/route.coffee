`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

EndpointGroupRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @modelFor('endpoint-groups').findBy 'id', params.endpoint_group_id
  actions:
    deleted: ->
      @transitionTo 'endpoint-groups'

`export default EndpointGroupRoute`
