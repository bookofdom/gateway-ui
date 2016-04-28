`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`

PushChannelPushDevice = Model.extend
  name: DS.attr 'string'
  type: DS.attr 'string'
  token: DS.attr 'string'
  expires: DS.attr 'string'

  # Relationships
  push_channel: DS.belongsTo 'push-channel', async: true
  push_messages: DS.hasMany 'push-channel-push-device-push-message', async: true

`export default PushChannelPushDevice`
