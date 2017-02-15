`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`

User = Model.extend
  name: DS.attr 'string'
  email: DS.attr 'string'
  password: DS.attr 'string'
  password_confirmation: DS.attr 'string'
  admin: DS.attr 'boolean'
  confirmed: DS.attr 'boolean'

  # Services
  session: Ember.inject.service()

  # Computed
  isAuthenticated: Ember.computed 'session.secure.email', ->
    userEmail = @get 'email'
    sessionEmail = @get 'session.secure.email'
    userEmail == sessionEmail

`export default User`
