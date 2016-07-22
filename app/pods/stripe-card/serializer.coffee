`import ApplicationSerializer from 'gateway/serializers/application'`
`import t from 'gateway/helpers/i18n'`

StripeCardSerializer = ApplicationSerializer.extend
  stripeService: Ember.inject.service 'stripe'

  serialize: (snapshot) ->
    serialized = @_super arguments...
    stripeService = @get 'stripeService'
    if !stripeService.validateCardNumber serialized.number
      serialized.validationError =
        field: 'number'
        message: t 'errors.invalid-cc-number'
    if !stripeService.validateCardExpiry serialized.exp_month, serialized.exp_year
      serialized.validationError =
        field: 'exp_year'
        message: t 'errors.invalid-cc-expiry'
    if !stripeService.validateCVC serialized.cvc
      serialized.validationError =
        field: 'cvc'
        message: t 'errors.invalid-cc-cvc'
    serialized

`export default StripeCardSerializer`
