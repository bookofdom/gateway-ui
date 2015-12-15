`import ApplicationAdapter from './application'`

PasswordResetConfirmationAdapter = ApplicationAdapter.extend
  pathForType: (type) ->
    path = Ember.String.underscore type
    path

`export default PasswordResetConfirmationAdapter`
