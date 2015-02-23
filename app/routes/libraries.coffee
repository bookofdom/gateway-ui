`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

LibrariesRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @modelFor('api').get 'libraries'

`export default LibrariesRoute`
