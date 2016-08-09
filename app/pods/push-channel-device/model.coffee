`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`

PushChannelDevice = Model.extend
  name: DS.attr 'string'
  type: DS.attr 'string'
  token: DS.attr 'string'
  expires: DS.attr 'string'
  qos: DS.attr 'number', defaultValue: 0

  # Relationships
  push_channel: DS.belongsTo 'push-channel', async: true
  push_messages: DS.hasMany 'push-channel-device-message', async: true

`export default PushChannelDevice`
