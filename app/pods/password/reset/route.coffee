`import Ember from 'ember'`

PasswordResetRoute = Ember.Route.extend
  notify: Ember.inject.service()
  actions:
    saved: ->
      @transitionTo 'password.reset.confirmation'
      @get('notify').info 'successes.password-reset'

`export default PasswordResetRoute`
