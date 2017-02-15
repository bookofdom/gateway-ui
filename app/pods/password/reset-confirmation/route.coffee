`import Ember from 'ember'`

PasswordResetConfirmationRoute = Ember.Route.extend
  notify: Ember.inject.service()
  actions:
    saved: ->
      @transitionTo 'login'
      @get('notify').info 'successes.password-reset-confirmation'

`export default PasswordResetConfirmationRoute`
