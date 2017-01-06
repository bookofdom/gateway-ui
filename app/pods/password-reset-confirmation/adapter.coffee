`import ApplicationAdapter from 'gateway-ui/pods/application/adapter'`

PasswordResetConfirmationAdapter = ApplicationAdapter.extend
  pathForType: (type) ->
    path = Ember.String.underscore type
    path

`export default PasswordResetConfirmationAdapter`
