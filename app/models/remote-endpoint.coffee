`import DS from 'ember-data'`
`import RemoteEndpointLike from 'gateway/models/remote-endpoint-like'`

RemoteEndpoint = RemoteEndpointLike.extend
  push_platform_codenames: Ember.computed 'push_platforms.@each.codename', 'environment_data.@each.push_platform_codenames', ->
    codenames = []
    @get('push_platforms')?.forEach (platform) ->
      codenames.push platform.get 'codename'
    @get('environment_data')?.forEach (environment) ->
      environment.get('push_platform_codenames')?.forEach (codename) ->
        codenames.push(codename) if codenames.indexOf(codename) < 0
    codenames
  # Relationships
  api: DS.belongsTo 'api', async: true
  environment_data: DS.hasMany 'remote-endpoint-environment-datum',
    async: false
    embedded: true

`export default RemoteEndpoint`
