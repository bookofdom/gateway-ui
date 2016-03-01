`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SharedComponentCallRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: (params) ->
    @modelFor('shared-component-calls').findBy 'id', params.shared_component_call_id

`export default SharedComponentCallRoute`
