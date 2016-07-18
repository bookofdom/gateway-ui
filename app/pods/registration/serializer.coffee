`import ApplicationSerializer from 'gateway/serializers/application'`

RegistrationSerializer = ApplicationSerializer.extend
  attrs:
    cc_number: false
    cc_cvc: false
    cc_exp_month: false
    cc_exp_year: false
    cc_billing_postal_code: false

  serialize: (snapshot) ->
    serialized = @_super arguments...
    model = snapshot.record
    if model.get 'isBillable'
      {
        cc_number,
        cc_cvc,
        cc_exp_month,
        cc_exp_year,
        cc_billing_postal_code
      } = snapshot.attributes()
      if !Stripe.card.validateCardNumber cc_number
        serialized.ccValidationError = true
        serialized.ccValidationMessage = t 'errors.invalid-cc-number'
      if !Stripe.card.Stripe.card.validateExpiry cc_exp_month, cc_exp_year
        serialized.ccValidationError = true
        serialized.ccValidationMessage = t 'errors.invalid-cc-expiry'
      if !Stripe.card.Stripe.card.validateCVC cc_cvc
        serialized.ccValidationError = true
        serialized.ccValidationMessage = t 'errors.invalid-cc-cvc'
    serialized

`export default RegistrationSerializer`
