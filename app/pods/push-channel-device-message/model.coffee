`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`

PushChannelDeviceMessage = Model.extend
  stamp: DS.attr 'string'
  body: DS.attr 'string'

  # Relationships
  push_device: DS.belongsTo 'push-channel-device', async: true

`export default PushChannelDeviceMessage`
