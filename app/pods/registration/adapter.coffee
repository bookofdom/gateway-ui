`import ApplicationAdapter from 'gateway/adapters/application'`

RegistrationAdapter = ApplicationAdapter.extend
  ajax: (url, type, options) ->
    outerSuper = @_super
    outerSelf = @
    outerArgs = arguments
    cardData = options?.data?.registration?.cardData
    delete options?.data?.registration?.cardData
    validationError = options?.data?.registration?.ccValidationError
    if validationError
      errorField = validationError.field
      errorMessage = validationError.message
    if errorField and errorMessage
      Ember.RSVP.reject new DS.InvalidError [
        detail: errorMessage
        source:
          pointer: "/data/attributes/#{errorField}"
      ]
    else if cardData and !validationError
      new Ember.RSVP.Promise (resolve, reject) ->
        Stripe.card.createToken cardData, (status, response) ->
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
