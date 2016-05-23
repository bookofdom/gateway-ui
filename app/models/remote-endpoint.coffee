`import DS from 'ember-data'`
`import RemoteEndpointLike from 'gateway/models/remote-endpoint-like'`

RemoteEndpoint = RemoteEndpointLike.extend
  push_platform_codenames: Ember.computed 'push_platforms.@each.codename', 'environment_data.@each.push_platform_codenames', ->
    codenames = @get('push_platforms').mapBy 'codename'
    @get('environment_data').mapBy('push_platform_codenames').reduce((a, b) ->
        a.concat(b)
      , codenames).uniq()
  # Relationships
  api: DS.belongsTo 'api', async: true
  environment_data: DS.hasMany 'remote-endpoint-environment-datum',
    async: false
    embedded: true

`export default RemoteEndpoint`
