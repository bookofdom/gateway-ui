`import Ember from 'ember'`
`import t from 'gateway/helpers/i18n'`

PushChannelPushManualMessagesRoute = Ember.Route.extend
  notify: Ember.inject.service()
  actions:
    saved: ->
      successMessage = t 'successes.push-manual-message'
      @transitionTo 'push-channels'
      @get('notify').info successMessage

`export default PushChannelPushManualMessagesRoute`
