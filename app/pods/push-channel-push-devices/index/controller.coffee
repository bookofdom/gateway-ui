`import Ember from 'ember'`

PushChannelPushDevicesIndexController = Ember.Controller.extend
  'push-channel-push-devices': Ember.inject.controller()
  'option-groups': Ember.computed.alias 'push-channel-push-devices.option-groups'

`export default PushChannelPushDevicesIndexController`
