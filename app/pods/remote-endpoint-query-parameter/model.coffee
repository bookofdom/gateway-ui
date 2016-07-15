`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`

RemoteEndpointQueryParameter = Model.extend
  name: DS.attr 'string'
  value: DS.attr 'string'

  # Relationships
  remote_endpoint: DS.belongsTo 'remote-endpoint', async: false
  environment_datum: DS.belongsTo 'remote-endpoint-environment-datum', async: false

`export default RemoteEndpointQueryParameter`
