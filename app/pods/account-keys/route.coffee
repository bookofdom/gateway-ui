`import Ember from 'ember'`

AccountKeysRoute = Ember.Route.extend
  model: -> @modelFor('account').get 'keys'
  actions:
    saved: ->
      @transitionTo 'account'
    deleted: ->
      @transitionTo 'account'
    canceled: ->
      @transitionTo 'account'

`export default AccountKeysRoute`
