`import Ember from 'ember'`
`import AuthenticatedRouteMixin from 'ember-simple-auth/mixins/authenticated-route-mixin'`

AccountRoute = Ember.Route.extend AuthenticatedRouteMixin,
  model: -> @store.findAll 'account'
  actions:
    refresh: -> @refresh()

`export default AccountRoute`
