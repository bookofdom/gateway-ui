`import DS from 'ember-data'`
`import RemoteEndpointLike from 'gateway-ui/pods/remote-endpoint-like/model'`

RemoteEndpoint = RemoteEndpointLike.extend
  # Relationships
  api: DS.belongsTo 'api', async: true
  environment_data: DS.hasMany 'remote-endpoint-environment-datum',
    async: false
    embeddedModel: true

  # Computed
  push_platform_codenames: Ember.computed 'push_platforms.@each.codename', 'environment_data.@each.push_platform_codenames', ->
    codenames = @get('push_platforms').mapBy 'codename'
    @get 'environment_data'
      .mapBy 'push_platform_codenames'
      .reduce ((a, b) -> a.concat b), codenames
      .uniq()

`export default RemoteEndpoint`
