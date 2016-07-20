`import ApplicationSerializer from 'gateway/serializers/application'`
`import t from 'gateway/helpers/i18n'`

RegistrationSerializer = ApplicationSerializer.extend
  attrs:
    cc_number:
      deserialize: false
    cc_cvc:
      deserialize: false
    cc_exp_month:
      deserialize: false
    cc_exp_year:
      deserialize: false
    cc_billing_postal_code:
      deserialize: false

  serialize: (snapshot) ->
    serialized = @_super arguments...
    model = snapshot.record
    if model.get 'isBillable'
      {
        cc_number,
        cc_cvc,
        cc_exp_month,
        cc_exp_year
      } = snapshot.attributes()
      if !Stripe.card.validateCardNumber cc_number
        serialized.ccValidationError =
          field: 'cc_number'
          message: t 'errors.invalid-cc-number'
      if !Stripe.card.validateExpiry cc_exp_month, cc_exp_year
        serialized.ccValidationError =
          field: 'cc_exp_year'
          message: t 'errors.invalid-cc-expiry'
      if !Stripe.card.validateCVC cc_cvc
        serialized.ccValidationError =
          field: 'cc_cvc'
          message: t 'errors.invalid-cc-cvc'
    serialized

`export default RegistrationSerializer`
