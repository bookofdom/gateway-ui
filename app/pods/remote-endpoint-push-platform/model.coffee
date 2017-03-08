`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`

RemoteEndpointPushPlatform = Model.extend
  name: DS.attr 'string'
  codename: DS.attr 'string'
  type: DS.attr 'string', defaultValue: 'ios'
  certificate: DS.attr 'string'
  password: DS.attr 'string'
  topic: DS.attr 'string'
  development: DS.attr 'boolean', defaultValue: false
  api_key: DS.attr 'string'
  connect_timeout: DS.attr 'number', defaultValue: 2
  ack_timeout: DS.attr 'number', defaultValue: 20
  timeout_retries: DS.attr 'number', defaultValue: 3
  token_authentication: DS.attr 'boolean', defaultValue: false
  authentication_key: DS.attr 'string'
  key_id: DS.attr 'string'
  team_id: DS.attr 'string'

  # Relationships
  remote_endpoint: DS.belongsTo 'remote-endpoint', async: false
  environment_datum: DS.belongsTo 'remote-endpoint-environment-datum', async: false

  # Computed
  platform: Ember.computed 'type', ->
    type = @get 'type'
    RemoteEndpointPushPlatform.types.findBy 'value', type

# Declare available types and their human-readable names
types = 'osx ios gcm fcm mqtt'.split(' ').map (type) ->
  nameKey: "types.push-platform.#{type}"
  slug: type
  value: type

RemoteEndpointPushPlatform.reopenClass
  types: types

`export default RemoteEndpointPushPlatform`
