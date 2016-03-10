`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

HostRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @modelFor('hosts').findBy 'id', params.host_id
  actions:
    deleted: ->
      @transitionTo 'hosts'

`export default HostRoute`
