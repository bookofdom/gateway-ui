`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`

PushMessage = Model.extend
  stamp: DS.attr 'string'
  body: DS.attr 'string'

  # Relationships
  push_device: DS.belongsTo 'push-channel-push-device', async: true

`export default PushMessage`
