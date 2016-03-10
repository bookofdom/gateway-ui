`import Ember from 'ember'`
`import config from  'gateway/config/environment'`
`import t from 'gateway/helpers/i18n'`

LoginController = Ember.Controller.extend
  session: Ember.inject.service()
  registrationEnabled: config.registrationEnabled?.toString() is 'true'
  authenticator: 'authenticator:gateway'
  labels:
    email: t('fields.email').capitalize()
    password: t('fields.password').capitalize()
  authenticationError: null
  'base-error': Ember.computed 'authenticationError', ->
    error = @get 'authenticationError'
    t('errors.login').capitalize() if error
  actions:
    authenticate: ->
      identification = @get 'identification'
      password = @get 'password'
      @get('session')
        .authenticate('authenticator:gateway', identification, password)
        .catch (reason) =>
          reason = reason.error or reason
          @set 'authenticationError', reason

`export default LoginController`
