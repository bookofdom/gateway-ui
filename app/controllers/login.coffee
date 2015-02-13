`import Ember from 'ember'`
`import LoginControllerMixin from 'simple-auth/mixins/login-controller-mixin'`
`import t from 'gateway/helpers/i18n'`

LoginController = Ember.Controller.extend LoginControllerMixin,
  authenticator: 'authenticator:gateway'
  labels:
    email: t('fields.email').capitalize()
    password: t('fields.password').capitalize()
  authenticationError: null
  authenticationErrorText: Ember.computed 'authenticationError', ->
    error = @get 'authenticationError'
    t("errors.#{error}").capitalize() if error
  'email-error': Ember.computed 'authenticationError', 'authenticationErrorText', ->
    if @get('authenticationError')?.indexOf('email') > 0
      @get 'authenticationErrorText'
  'password-error': Ember.computed 'authenticationError', 'authenticationErrorText', ->
    if @get('authenticationError')?.indexOf('password') > 0
      @get 'authenticationErrorText'

`export default LoginController`
