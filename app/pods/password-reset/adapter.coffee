`import ApplicationAdapter from 'gateway/pods/application/adapter'`

PasswordResetAdapter = ApplicationAdapter.extend
  pathForType: (type) ->
    path = Ember.String.underscore type
    path

`export default PasswordResetAdapter`
