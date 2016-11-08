`import ApplicationAdapter from 'gateway/pods/application/adapter'`

RegistrationActivationAdapter = ApplicationAdapter.extend
  pathForType: (type) ->
    path = Ember.String.underscore type
    path

`export default RegistrationActivationAdapter`
