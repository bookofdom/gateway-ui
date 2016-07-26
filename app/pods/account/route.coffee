`import Ember from 'ember'`

AccountRoute = Ember.Route.extend
  model: ->
    store = @store
    new Ember.RSVP.Promise (resolve, reject) ->
      store.findAll('account').then (accounts) ->
        resolve accounts.get('firstObject')

`export default AccountRoute`
