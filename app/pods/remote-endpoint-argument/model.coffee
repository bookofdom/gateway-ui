`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`

RemoteEndpointArgument = Model.extend
  value: DS.attr 'string'

  # Relationships
  remote_endpoint: DS.belongsTo 'remote-endpoint', async: false
  environment_datum: DS.belongsTo 'remote-endpoint-environment-datum', async: false

`export default RemoteEndpointArgument`
