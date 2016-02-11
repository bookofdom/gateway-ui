`import Ember from 'ember'`
`import t from 'gateway/helpers/i18n'`

PasswordResetRoute = Ember.Route.extend
  notify: Ember.inject.service()
  actions:
    saved: ->
      successMessage = t 'successes.password-reset'
      @transitionTo 'login'
      @get('notify').info successMessage

`export default PasswordResetRoute`