`import Ember from 'ember'`

AccountIndexRoute = Ember.Route.extend
  afterModel: -> @transitionTo 'account.edit'

`export default AccountIndexRoute`
