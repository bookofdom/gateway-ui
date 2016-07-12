`import Ember from 'ember'`

PushChannelDevicesIndexController = Ember.Controller.extend
  'push-channel-devices': Ember.inject.controller()
  'option-groups': Ember.computed.alias 'push-channel-devices.option-groups'

  fields: [
    name: 'name'
    label: 'fields.name'
    type: 'string'
  ,
    name: 'type'
    label: 'fields.type'
    type:  'string'
  ,
    name: 'expires'
    label: 'fields.expires'
    type: 'datetime'
  ]

`export default PushChannelDevicesIndexController`
