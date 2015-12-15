`import ApplicationAdapter from './application'`

PasswordResetAdapter = ApplicationAdapter.extend
  pathForType: (type) ->
    path = Ember.String.underscore type
    path

`export default PasswordResetAdapter`
