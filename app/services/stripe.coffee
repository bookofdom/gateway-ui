`import Ember from 'ember'`

# Encapsulates critical Stripe functionality.
# Modules depending on Stripe should always use this service,
# checking that enabled == true.  This ensures the app can
# function even when Stripe is unavailable.

StripeService = Ember.Service.extend Ember.Evented,
  _stripe: window.Stripe
  enabled: false
  init: ->
    @_super arguments...
    @set('enabled', true) if @get('_stripe')
  createCardToken: ->
    @get('_stripe.card').createToken arguments...
  validateCardNumber: ->
    @get('_stripe.card').validateCardNumber arguments...
  validateCardExpiry: ->
    @get('_stripe.card').validateExpiry arguments...
  validateCVC: ->
    @get('_stripe.card').validateCVC arguments...

`export default StripeService`
