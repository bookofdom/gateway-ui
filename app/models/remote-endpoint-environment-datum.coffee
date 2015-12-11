`import DS from 'ember-data'`
`import RemoteEndpointLike from './remote-endpoint-like'`

RemoteEndpointEnvironmentDatum = RemoteEndpointLike.extend
  # Relationships
  remote_endpoint: DS.belongsTo 'remote-endpoint', async: false
  environment: DS.belongsTo 'environment',
    async: false
    stains: true

  errors: Ember.computed 'remote_endpoint.errors.[]', 'remote_endpoint.errors.length', ->
    @get 'remote_endpoint.errors'

`export default RemoteEndpointEnvironmentDatum`
