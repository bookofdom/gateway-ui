`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Model from './model'`
`import t from 'gateway/helpers/i18n'`

User = Model.extend
  name: DS.attr 'string'
  email: DS.attr 'string'
  password: DS.attr 'string'
  password_confirmation: DS.attr 'string'
  admin: DS.attr 'boolean'
  confirmed: DS.attr 'boolean'

  # Services
  session: Ember.inject.service 'simple-auth-session:main'

  # Computed
  isAuthenticated: Ember.computed 'session.secure.email', ->
    userEmail = @get 'email'
    sessionEmail = @get 'session.secure.email'
    userEmail == sessionEmail
  displayName: Ember.computed 'name', 'isAuthenticated', ->
    name = @get 'name'
    isAuthenticated = @get 'isAuthenticated'
    displayName = name
    displayName = "#{displayName} (#{t('states.active')})" if isAuthenticated
    displayName

`export default User`
