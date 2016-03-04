`import Ember from 'ember'`
`import LoginControllerMixin from 'simple-auth/mixins/login-controller-mixin'`
`import config from  'gateway/config/environment'`
`import t from 'gateway/helpers/i18n'`

LoginController = Ember.Controller.extend LoginControllerMixin,
  registrationEnabled: config.registrationEnabled?.toString() is 'true'
  authenticator: 'authenticator:gateway'
  labels:
    email: t('fields.email').capitalize()
    password: t('fields.password').capitalize()
  authenticationError: null
  'base-error': Ember.computed 'authenticationError', ->
    error = @get 'authenticationError'
    t('errors.login').capitalize() if error

`export default LoginController`
