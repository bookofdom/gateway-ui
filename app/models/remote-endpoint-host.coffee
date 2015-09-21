`import DS from 'ember-data'`
`import Model from './model'`

RemoteEndpointHost = Model.extend
  host: DS.attr 'string'
  port: DS.attr 'number', defaultValue: 27017

  # Relationships
  remote_endpoint: DS.belongsTo 'remote-endpoint', async: false

`export default RemoteEndpointHost`
