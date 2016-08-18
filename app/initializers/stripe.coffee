`import config from  'gateway/config/environment'`

StripeInitializer =
  name: 'stripe'
  initialize: (app) ->
    key = config.stripe?.publishableKey
    window.Stripe?.setPublishableKey key if key
    app.inject 'adapter', 'stripeService', 'service:stripe'

`export default StripeInitializer`
