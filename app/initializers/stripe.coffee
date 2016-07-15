`import config from  'gateway/config/environment'`

StripeInitializer =
  name: 'stripe'
  initialize: (app) ->
    key = config.stripe?.publishableKey
    Stripe.setPublishableKey key if key

`export default StripeInitializer`
