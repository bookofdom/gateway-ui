`import ApplicationAdapter from 'gateway/adapters/application'`

RegistrationAdapter = ApplicationAdapter.extend
  ajax: (url, type, options) ->
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
    else
      @_super arguments...

`export default RegistrationAdapter`
