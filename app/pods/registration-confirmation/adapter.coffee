`import ApplicationAdapter from 'gateway-ui/pods/application/adapter'`

RegistrationConfirmationAdapter = ApplicationAdapter.extend
  pathForType: (type) ->
    path = Ember.String.underscore type
    path

`export default RegistrationConfirmationAdapter`
