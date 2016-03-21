`import ApplicationAdapter from 'gateway/adapters/application'`

PasswordResetConfirmationAdapter = ApplicationAdapter.extend
  pathForType: (type) ->
    path = Ember.String.underscore type
    path

`export default PasswordResetConfirmationAdapter`
