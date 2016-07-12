`import Ember from 'ember'`

PushChannelMessagesIndexController = Ember.Controller.extend
  'push-channel-messages': Ember.inject.controller()
  push_channels: Ember.computed.alias 'push-channel-messages.push_channels'
  'option-groups': Ember.computed 'push_channels.[]', ->
    'push_channel': @get('push_channels').filterBy 'isNew', false

  fields: [
    name: 'stamp'
    label: 'fields.stamp'
    type: 'datetime'
  ,
    name: 'body'
    label: 'fields.body'
    type: 'code'
  ]

`export default PushChannelMessagesIndexController`
