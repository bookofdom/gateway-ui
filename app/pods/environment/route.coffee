`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

EnvironmentRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @modelFor('environments').findBy 'id', params.environment_id
  actions:
    deleted: ->
      @transitionTo 'environments'

`export default EnvironmentRoute`
