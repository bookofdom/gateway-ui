`import DS from 'ember-data'`
`import RemoteEndpointLike from './remote-endpoint-like'`

RemoteEndpointEnvironmentDatum = RemoteEndpointLike.extend
  # Relationships
  remote_endpoint: DS.belongsTo 'remote-endpoint', async: false
  environment: DS.belongsTo 'environment',
    async: false
    stains: true
  scratch_pads: DS.hasMany 'remote-endpoint-environment-datum-scratch-pad', async: true

`export default RemoteEndpointEnvironmentDatum`
