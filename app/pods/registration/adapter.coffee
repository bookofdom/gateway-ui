`import ApplicationAdapter from 'gateway/adapters/application'`

RegistrationAdapter = ApplicationAdapter.extend
  ajax: (url, type, options) ->
    error = options?.data?.registration?.ccValidationError
    if error
      Ember.RSVP.reject new DS.InvalidError [
        detail: error.message
        source:
          pointer: "/data/attributes/#{error.field}"
      ]
    else
      @_super arguments...

`export default RegistrationAdapter`
