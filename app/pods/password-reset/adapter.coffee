`import ApplicationAdapter from 'gateway/adapters/application'`

PasswordResetAdapter = ApplicationAdapter.extend
  pathForType: (type) ->
    path = Ember.String.underscore type
    path

`export default PasswordResetAdapter`
