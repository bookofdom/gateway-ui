`import DS from 'ember-data'`
`import Model from 'gateway/pods/model/model'`

PushManualMessage = Model.extend
  environment: DS.attr 'string'
  body: DS.attr 'string', defaultValue: '{}'

  # Relationships
  push_channel: DS.belongsTo 'push-channel', async: true

`export default PushManualMessage`
