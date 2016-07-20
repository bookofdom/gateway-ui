`import ApplicationAdapter from 'gateway/adapters/application'`

RegistrationAdapter = ApplicationAdapter.extend
  stripeService: Ember.inject.service 'stripe'
  ajax: (url, type, options) ->
    outerSuper = @_super
    outerSelf = @
    outerArgs = arguments
    stripeService = @get 'stripeService'
    cardData = options?.data?.registration?.cardData
    delete options?.data?.registration?.cardData
    validationError = options?.data?.registration?.ccValidationError
    if validationError
      Ember.RSVP.reject new DS.InvalidError [
        detail: validationError.field
        source:
          pointer: "/data/attributes/#{validationError.message}"
      ]
    else if cardData and !validationError
      new Ember.RSVP.Promise (resolve, reject) ->
        stripeService.createCardToken cardData, (status, response) ->
          if response.error
            reject new DS.InvalidError [
              detail: response.error.message
              source:
                pointer: "/data/attributes/cc_#{response.error.param}"
            ]
          else
            options?.data?.registration?.stripe_card_token = response.id
            outerSuper.apply(outerSelf, outerArgs)
              .then (response) -> resolve response
              .catch (response) -> reject response
    else
      @_super arguments...

`export default RegistrationAdapter`
