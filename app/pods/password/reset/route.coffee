`import Ember from 'ember'`
`import t from 'gateway/helpers/i18n'`

PasswordResetRoute = Ember.Route.extend
  notify: Ember.inject.service()
  actions:
    saved: ->
      successMessage = t 'successes.password-reset'
      @transitionTo 'password.reset.confirmation'
      @get('notify').info successMessage

`export default PasswordResetRoute`
