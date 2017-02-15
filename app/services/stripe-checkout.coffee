`import Ember from 'ember'`
`import config from  'gateway-ui/config/environment'`

# Encapsulates Stripe Checkout.

StripeCheckoutService = Ember.Service.extend Ember.Evented,
  i18n: Ember.inject.service()
  session: Ember.inject.service()
  _stripeCheckout: window.StripeCheckout
  isEnabled: Ember.computed '_stripeCheckout', ->
    @get('_stripeCheckout')?
  checkout: Ember.computed ->
    @get('_stripeCheckout')?.configure
      key: config.stripe?.publishableKey
      image: 'https://stripe.com/img/documentation/checkout/marketplace.png'
      locale: @get('i18n.locale')
      allowRememberMe: false
      email: @get 'session.session.authenticated.email'
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
