`import DS from 'ember-data'`
`import Model from './model'`

RemoteEndpointEnvironmentDatum = Model.extend
  url: DS.attr 'string'
  method: DS.attr 'string'

  # Relationships
  remote_endpoint: DS.belongsTo 'remote-endpoint', async: false
  environment: DS.belongsTo 'environment',
    async: false
    stains: true
  headers: DS.hasMany 'remote-endpoint-header',
    async: false
    stains: true
    embedded: true
  query: DS.hasMany 'remote-endpoint-query-parameter',
    async: false
    stains: true
    embedded: true

`export default RemoteEndpointEnvironmentDatum`
