`import Ember from 'ember'`

PushChannelDevicesIndexController = Ember.Controller.extend
  'push-channel-devices': Ember.inject.controller()
  'option-groups': Ember.computed.alias 'push-channel-devices.option-groups'

`export default PushChannelDevicesIndexController`
