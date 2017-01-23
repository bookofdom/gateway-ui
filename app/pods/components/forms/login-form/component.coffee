`import Ember from 'ember'`
`import t from 'gateway-ui/helpers/i18n'`
`import config from 'gateway-ui/config/environment'`

LoginFormComponent = Ember.Component.extend
  session: Ember.inject.service()

  tagName: 'form'
  classNames: ['ap-form-login']

  registration_enabled: config.registration_enabled?.toString() is 'true'
  authenticator: 'authenticator:gateway'
  authenticateAction: 'authenticate'

  labels:
    email: t 'fields.email'
    password: t 'fields.password'

  authenticationError: null
  'base-error': Ember.computed 'authenticationError', ->
    error = @get 'authenticationError'
    t('errors.login').capitalize() if error

  submit: ->
    @send 'authenticate'
    false

  actions:
    authenticate: ->
      identification = @get 'identification'
      password = @get 'password'
      @set 'password', ''
      @get 'session'
        .authenticate 'authenticator:gateway', identification, password
        .catch (reason) =>
          reason = reason.error or reason
          @set 'authenticationError', reason

`export default LoginFormComponent`
