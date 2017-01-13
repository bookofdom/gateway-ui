`import DS from 'ember-data'`
`import RemoteEndpointLike from 'gateway-ui/pods/remote-endpoint-like/model'`

RemoteEndpointEnvironmentDatum = RemoteEndpointLike.extend
  # Relationships
  remote_endpoint: DS.belongsTo 'remote-endpoint', async: false
  environment: DS.belongsTo 'environment',
    async: false
    stains: true
  scratch_pads: DS.hasMany 'remote-endpoint-environment-datum-scratch-pad', async: true

`export default RemoteEndpointEnvironmentDatum`
