`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

EnvironmentsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @modelFor('api').get 'environments'

`export default EnvironmentsRoute`
