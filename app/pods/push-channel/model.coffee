`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`

PushChannel = Model.extend
  name: DS.attr 'string'
  expires: DS.attr 'string'

  # Relationships
  api: DS.belongsTo 'api',
    async: false
    stains: true
  remote_endpoint: DS.belongsTo 'remote-endpoint',
    async: false
    stains: true
  push_devices: DS.hasMany 'push-channel-device', async: true

`export default PushChannel`
