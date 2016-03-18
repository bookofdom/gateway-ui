`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

StoreCollectionsRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @store.findAll 'store-collection'
  actions:
    saved: (collection) ->
      @transitionTo 'store-objects', collection

`export default StoreCollectionsRoute`
