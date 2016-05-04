`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`

PushChannelPushManualMessage = Model.extend
  environment: DS.attr 'string'
  body: DS.attr 'string'

  # Relationships
  push_channel: DS.belongsTo 'push-channel', async: true

`export default PushChannelPushManualMessage`
