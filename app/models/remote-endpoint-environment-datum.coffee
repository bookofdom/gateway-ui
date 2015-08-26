`import DS from 'ember-data'`
`import Model from './model'`

RemoteEndpointEnvironmentDatum = Model.extend
  url: DS.attr 'string'
  method: DS.attr 'string'

  # Relationships
  environment: DS.belongsTo 'environment', async: true
  remote_endpoint: DS.belongsTo 'remote-endpoint', async: false
  headers: DS.hasMany 'remote-endpoint-header',
    async: false
    embedded: true
  query: DS.hasMany 'remote-endpoint-query-parameter',
    async: false
    embedded: true

`export default RemoteEndpointEnvironmentDatum`
