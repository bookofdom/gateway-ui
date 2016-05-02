`import Ember from 'ember'`

PushChannelsIndexController = Ember.Controller.extend
  'push-channels': Ember.inject.controller()
  'apis': Ember.computed.alias 'push-channels.apis'

`export default PushChannelsIndexController`
