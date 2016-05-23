`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`

RemoteEndpointPushPlatform = Model.extend
  name: DS.attr 'string'
  codename: DS.attr 'string'
  type: DS.attr 'string', defaultValue: 'ios'
  certificate: DS.attr 'string'
  password: DS.attr 'string'
  topic: DS.attr 'string'
  development: DS.attr 'boolean', defaultValue: false
  api_key: DS.attr 'string'

  # Relationships
  remote_endpoint: DS.belongsTo 'remote-endpoint', async: false
  environment_datum: DS.belongsTo 'remote-endpoint-environment-datum', async: false

`export default RemoteEndpointPushPlatform`
