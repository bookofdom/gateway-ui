`import Ember from 'ember'`

PushChannelsIndexController = Ember.Controller.extend
  'push-channels': Ember.inject.controller()
  'apis': Ember.computed.alias 'push-channels.apis'

  actions:
    'push-manual-message': (push_channel) ->
      @transitionToRoute 'push-manual-messages', push_channel

`export default PushChannelsIndexController`
