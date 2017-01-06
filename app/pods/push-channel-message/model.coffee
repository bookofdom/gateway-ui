`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`

PushChannelMessage = Model.extend
  stamp: DS.attr 'string'
  body: DS.attr 'string', defaultValue: '{}'

  # Relationships
  push_channel: DS.belongsTo 'push-channel', async: true

`export default PushChannelMessage`
