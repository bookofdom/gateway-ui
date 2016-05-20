`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

ManageRoute = Ember.Route.extend AuthenticatedRouteMixin,
  afterModel: -> @transitionTo 'store-collections'

`export default ManageRoute`
