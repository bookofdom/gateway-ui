`import DS from 'ember-data'`
`import RemoteEndpointLike from 'gateway/models/remote-endpoint-like'`

RemoteEndpointEnvironmentDatum = RemoteEndpointLike.extend
  # Relationships
  remote_endpoint: DS.belongsTo 'remote-endpoint', async: false
  environment: DS.belongsTo 'environment',
    async: false
    stains: true

`export default RemoteEndpointEnvironmentDatum`
