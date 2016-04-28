`import DS from 'ember-data'`
`import RemoteEndpointLike from 'gateway/models/remote-endpoint-like'`

RemoteEndpointEnvironmentDatum = RemoteEndpointLike.extend
  push_platform_codenames: Ember.computed 'push_platforms.@each.codename', ->
    codenames = []
    @get('push_platforms')?.forEach (platform) ->
      codenames.push platform.get 'codename'
    codenames
  # Relationships
  remote_endpoint: DS.belongsTo 'remote-endpoint', async: false
  environment: DS.belongsTo 'environment',
    async: false
    stains: true
  scratch_pads: DS.hasMany 'remote-endpoint-environment-datum-scratch-pad', async: true

`export default RemoteEndpointEnvironmentDatum`
