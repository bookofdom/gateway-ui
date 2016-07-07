`import Ember from 'ember'`

PushChannelsIndexController = Ember.Controller.extend
  'push': Ember.inject.controller()
  'apis': Ember.computed.alias 'push.apis'

  actions:
    'push-manual-message': (channel) ->
      @transitionToRoute 'push-manual-messages', channel

`export default PushChannelsIndexController`
