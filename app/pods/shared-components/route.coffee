`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SharedComponentsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @modelFor('api').get 'shared_components'
  actions:
    saved: ->
      # no op (this event is for use by the new type component route)

`export default SharedComponentsRoute`
