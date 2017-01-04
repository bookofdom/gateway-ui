`import Ember from 'ember'`
`import t from 'gateway-ui/helpers/i18n'`

PushManualMessagesRoute = Ember.Route.extend
  notify: Ember.inject.service()
  actions:
    saved: ->
      successMessage = t 'successes.push-manual-message'
      @transitionTo 'push-channels'
      @get('notify').info successMessage

`export default PushManualMessagesRoute`
