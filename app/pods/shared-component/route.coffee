`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SharedComponentRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @modelFor('shared-components').findBy 'id', params.shared_component_id
  actions:
    deleted: ->
      @transitionTo 'shared-components'

`export default SharedComponentRoute`
