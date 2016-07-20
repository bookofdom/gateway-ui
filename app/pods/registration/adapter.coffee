`import ApplicationAdapter from 'gateway/adapters/application'`

RegistrationAdapter = ApplicationAdapter.extend
  excludedFields: [
    'cc_number'
    'cc_cvc'
    'cc_exp_month'
    'cc_exp_year'
    'cc_billing_postal_code'
  ]

  removeExcludedFields: (data={}) ->
    (delete data[fieldName]) for fieldName in @get 'excludedFields'

  ajax: (url, type, options) ->
    outerSuper = @_super
    outerSelf = @
    outerArgs = arguments
    {
      cc_number,
      cc_cvc,
      cc_exp_month,
      cc_exp_year,
      cc_billing_postal_code
    } = options?.data?.registration
    ccFilled = !!(cc_number and cc_cvc and cc_exp_month and cc_exp_year and cc_billing_postal_code)
    validationError = options?.data?.registration?.ccValidationError
    @removeExcludedFields options?.data?.registration
    if validationError
      errorField = validationError.field
      errorMessage = validationError.message
    if errorField and errorMessage
      Ember.RSVP.reject new DS.InvalidError [
        detail: errorMessage
        source:
          pointer: "/data/attributes/#{errorField}"
      ]
    else if ccFilled and !validationError
      stripeData =
        number: cc_number
        cvc: cc_cvc
        exp_month: cc_exp_month
        exp_year: cc_exp_year
        address_zip: cc_billing_postal_code
      new Ember.RSVP.Promise (resolve, reject) ->
        Stripe.card.createToken stripeData, (status, response) ->
          if response.error
            reject new DS.InvalidError [
              detail: response.error.message
              source:
                pointer: "/data/attributes/cc_#{response.error.param}"
            ]
          else
            outerSuper.apply(outerSelf, outerArgs)
              .then (response) -> resolve response
              .catch (response) -> reject response
    else
      @_super arguments...

`export default RegistrationAdapter`
