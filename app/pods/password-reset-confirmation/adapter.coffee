`import ApplicationAdapter from 'gateway/pods/application/adapter'`

PasswordResetConfirmationAdapter = ApplicationAdapter.extend
  pathForType: (type) ->
    path = Ember.String.underscore type
    path

`export default PasswordResetConfirmationAdapter`
