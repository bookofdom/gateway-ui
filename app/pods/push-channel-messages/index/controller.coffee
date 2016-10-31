`import Ember from 'ember'`

PushChannelMessagesIndexController = Ember.Controller.extend

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
