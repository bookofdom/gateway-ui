`import Ember from 'ember'`

isFunction = (arg1) ->

StripeService = Ember.Service.extend Ember.Evented,
  _stripe: window.Stripe
  enabled: false
  init: ->
    @_super arguments...
    @set('enabled', true) if @get('_stripe')
  createCardToken: ->
    enabled = @get 'enabled'
    @get('_stripe.card').createToken arguments... if enabled
  validateCardNumber: ->
    enabled = @get 'enabled'
    @get('_stripe.card').validateCardNumber arguments... if enabled
  validateCardExpiry: ->
    enabled = @get 'enabled'
    @get('_stripe.card').validateExpiry arguments... if enabled
  validateCVC: ->
    enabled = @get 'enabled'
    @get('_stripe.card').validateCVC arguments... if enabled

`export default StripeService`
