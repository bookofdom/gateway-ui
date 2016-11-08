`import ApplicationAdapter from 'gateway/pods/application/adapter'`

RegistrationConfirmationAdapter = ApplicationAdapter.extend
  pathForType: (type) ->
    path = Ember.String.underscore type
    path

`export default RegistrationConfirmationAdapter`
