`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`
`import t from 'gateway/helpers/i18n'`

RemoteEndpointPushPlatform = Model.extend
  name: DS.attr 'string'
  codename: DS.attr 'string'
  type: DS.attr 'string', defaultValue: 'ios'
  certificate: DS.attr 'string'
  password: DS.attr 'string'
  topic: DS.attr 'string'
  development: DS.attr 'boolean', defaultValue: false
  api_key: DS.attr 'string'

  # Relationships
  remote_endpoint: DS.belongsTo 'remote-endpoint', async: false
  environment_datum: DS.belongsTo 'remote-endpoint-environment-datum', async: false

  # Computed
  platform: Ember.computed 'type', ->
    type = @get 'type'
    RemoteEndpointPushPlatform.types.findBy 'value', type
  platformName: Ember.computed.alias 'platform.name'

# Declare available types and their human-readable names
types = 'osx ios gcm'.split(' ').map (type) ->
  name: t "types.push-platform.#{type}"
  slug: type
  value: type

RemoteEndpointPushPlatform.reopenClass
  types: types

`export default RemoteEndpointPushPlatform`
