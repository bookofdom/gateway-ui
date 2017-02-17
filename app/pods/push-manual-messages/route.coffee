`import Ember from 'ember'`

PushManualMessagesRoute = Ember.Route.extend
  notify: Ember.inject.service()
  actions:
    saved: ->
      @transitionTo 'push-channels'
      @get('notify').info 'successes.push-manual-message'

`export default PushManualMessagesRoute`
