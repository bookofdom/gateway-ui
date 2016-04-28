`import Ember from 'ember'`

PushChannelsIndexController = Ember.Controller.extend
  'push-channels': Ember.inject.controller()
  'api': Ember.computed.alias 'push-channels.api'

`export default PushChannelsIndexController`
