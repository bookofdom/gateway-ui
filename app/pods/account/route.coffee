`import Ember from 'ember'`

AccountRoute = Ember.Route.extend
  model: (params) -> @modelFor('accounts').findBy 'id', params.account_id
  actions:
    deleted: ->
      @transitionTo 'accounts'

`export default AccountRoute`
