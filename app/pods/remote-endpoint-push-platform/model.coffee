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
  connect_timeout: DS.attr 'number', defaultValue: 2
  ack_timeout: DS.attr 'number', defaultValue: 20
  timeout_retries: DS.attr 'number', defaultValue: 3

  # Services
  session: Ember.inject.service()

  # Computed
  username: Ember.computed 'session.session.authenticated.email', 'apiName',
  'remoteEndpointCodename', 'codename', 'remote_endpoint', 'environment_datum', ->
    email = @get 'session.session.authenticated.email'
    apiName = @get 'apiName'
    remoteEndpointCodename = @get 'remoteEndpointCodename'
    codename = @get('codename') || ""
    remoteEndpoint = @get('remote_endpoint') || @get('environment_datum.remote_endpoint')
    if remoteEndpoint?
      apiName = remoteEndpoint.get 'api.name'
      remoteEndpointCodename = remoteEndpoint.get 'codename'
    "#{email},#{apiName},#{remoteEndpointCodename},#{codename}"

  # Relationships
  remote_endpoint: DS.belongsTo 'remote-endpoint', async: false
  environment_datum: DS.belongsTo 'remote-endpoint-environment-datum', async: false

  # Computed
  platform: Ember.computed 'type', ->
    type = @get 'type'
    RemoteEndpointPushPlatform.types.findBy 'value', type
  platformName: Ember.computed.alias 'platform.name'

# Declare available types and their human-readable names
types = 'osx ios gcm mqtt'.split(' ').map (type) ->
  name: t "types.push-platform.#{type}"
  slug: type
  value: type

RemoteEndpointPushPlatform.reopenClass
  types: types

`export default RemoteEndpointPushPlatform`
