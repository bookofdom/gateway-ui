`import Ember from 'ember'`
`import t from 'gateway/helpers/i18n'`

PasswordResetConfirmationRoute = Ember.Route.extend
  notify: Ember.inject.service()
  actions:
    saved: ->
      successMessage = t 'successes.password-reset-confirmation'
      @transitionTo 'login'
      @get('notify').info successMessage

`export default PasswordResetConfirmationRoute`
