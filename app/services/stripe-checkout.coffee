`import Ember from 'ember'`
`import config from  'gateway-ui/config/environment'`

# Encapsulates Stripe Checkout.

StripeCheckoutService = Ember.Service.extend Ember.Evented,
  _i18n: window.i18n
  _stripeCheckout: window.StripeCheckout
  isEnabled: Ember.computed '_stripeCheckout', ->
    @get('_stripeCheckout')?
  checkout: Ember.computed ->
    @get('_stripeCheckout')?.configure
      key: config.stripe?.publishableKey
      image: 'https://stripe.com/img/documentation/checkout/marketplace.png'
      locale: @get('_i18n').lng()
  getToken: (options) ->
    isEnabled = @get 'isEnabled'
    checkout = @get 'checkout'
    new Ember.RSVP.Promise (resolve, reject) ->
      if !isEnabled
        resolve()
      else
        options.token = resolve
        checkout.open options

`export default StripeCheckoutService`
