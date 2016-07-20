`import ApplicationSerializer from 'gateway/serializers/application'`
`import t from 'gateway/helpers/i18n'`

RegistrationSerializer = ApplicationSerializer.extend
  stripeService: Ember.inject.service 'stripe'

  attrs:
    cc_number:
      serialize: false
      deserialize: false
    cc_cvc:
      serialize: false
      deserialize: false
    cc_exp_month:
      serialize: false
      deserialize: false
    cc_exp_year:
      serialize: false
      deserialize: false
    cc_billing_postal_code:
      serialize: false
      deserialize: false

  serialize: (snapshot) ->
    serialized = @_super arguments...
    stripeService = @get 'stripeService'
    model = snapshot.record
    isBillable = model.get 'isBillable'
    cardData = model.get 'cardData'
    if model.get 'isBillable'
      if !stripeService.validateCardNumber cardData.number
        serialized.ccValidationError =
          field: 'cc_number'
          message: t 'errors.invalid-cc-number'
      if !stripeService.validateCardExpiry cardData.exp_month, cardData.exp_year
        serialized.ccValidationError =
          field: 'cc_exp_year'
          message: t 'errors.invalid-cc-expiry'
      if !stripeService.validateCVC cardData.cvc
        serialized.ccValidationError =
          field: 'cc_cvc'
          message: t 'errors.invalid-cc-cvc'
      serialized.cardData = cardData
    serialized

`export default RegistrationSerializer`
