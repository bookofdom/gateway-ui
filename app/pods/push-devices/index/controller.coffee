`import Ember from 'ember'`

PushDevicesIndexController = Ember.Controller.extend
  'push-devices': Ember.inject.controller()
  'option-groups': Ember.computed.alias 'push-devices.option-groups'

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

`export default PushDevicesIndexController`
