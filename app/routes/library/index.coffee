`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'simple-auth/mixins/authenticated-route-mixin'`

LibraryIndexRoute = Ember.Route.extend AuthenticatedRouteMixin,
  afterModel: -> @transitionTo 'library.edit'

`export default LibraryIndexRoute`
