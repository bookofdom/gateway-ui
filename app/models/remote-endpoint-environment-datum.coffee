`import DS from 'ember-data'`
`import RemoteEndpointLike from './remote-endpoint-like'`

RemoteEndpointEnvironmentDatum = RemoteEndpointLike.extend
  # Relationships
  remote_endpoint: DS.belongsTo 'remote-endpoint', async: false
  environment: DS.belongsTo 'environment',
    async: false
    stains: true
  pads: DS.hasMany 'scratch-pad', async: true

`export default RemoteEndpointEnvironmentDatum`
