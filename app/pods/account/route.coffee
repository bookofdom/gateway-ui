`import Ember from 'ember'`
`import PlansRouteMixin from 'gateway/mixins/plans-route'`

AccountRoute = Ember.Route.extend PlansRouteMixin,
  model: ->
    store = @store
    new Ember.RSVP.Promise (resolve, reject) ->
      store.findAll('account').then (accounts) ->
        resolve accounts.get('firstObject')
  renderTemplate: ->
    @_super arguments...
    @render 'admin/secondary-sidebar',
      outlet: 'sidebar'
      into: 'account'

`export default AccountRoute`
