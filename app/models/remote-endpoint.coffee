`import DS from 'ember-data'`
`import RemoteEndpointLike from './remote-endpoint-like'`

RemoteEndpoint = RemoteEndpointLike.extend
  # Relationships
  api: DS.belongsTo 'api', async: true
  environment_data: DS.hasMany 'remote-endpoint-environment-datum',
    async: false
    embedded: true
    errors: true

`export default RemoteEndpoint`
