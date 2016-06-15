`import Ember from 'ember'`

PushDevicesIndexController = Ember.Controller.extend
  'push-devices': Ember.inject.controller()
  'option-groups': Ember.computed.alias 'push-devices.option-groups'

`export default PushDevicesIndexController`
