`import Ember from 'ember'`

PushChannelsIndexController = Ember.Controller.extend
  'manage': Ember.inject.controller()
  'apis': Ember.computed.alias 'manage.model.apis'

  actions:
    'push-manual-message': (push_channel) ->
      @transitionToRoute 'push-channel-push-manual-messages', push_channel

`export default PushChannelsIndexController`
