`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

SharedComponentCallsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @modelFor('shared-component').get 'calls'

`export default SharedComponentCallsRoute`
