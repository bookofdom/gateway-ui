`import Ember from 'ember'`
`import PlansRouteMixin from 'gateway-ui/mixins/plans-route'`

AccountRoute = Ember.Route.extend PlansRouteMixin,
  model: ->
    store = @store
    new Ember.RSVP.Promise (resolve, reject) ->
      store.findAll('account').then (accounts) ->
        resolve accounts.get('firstObject')

`export default AccountRoute`
