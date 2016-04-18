`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`
`import t from 'gateway/helpers/i18n'`

RemoteEndpointLike = Model.extend
  type: DS.attr 'string', defaultValue: 'http'
  name: DS.attr 'string'
  codename: DS.attr 'string'
  description: DS.attr 'string'
  status: DS.attr 'string'
  status_message: DS.attr 'string'
  # http
  method: DS.attr 'string'
  # soap
  wsdl: DS.attr 'string'
  service_name: DS.attr 'string'
  auth_scheme: DS.attr 'string'
  # sqlserver
  schema: DS.attr 'string'
  # postgres
  sslmode: DS.attr 'string', defaultValue: 'prefer'
  # mongodb
  limit: DS.attr 'number', defaultValue: 16
  # http
  # soap
  url: DS.attr 'string'
  # sqlserver
  # postgres
  # mysql
  database: DS.attr 'string'
  transactions: DS.attr 'boolean'
  timeout: DS.attr 'number'
  maxopen: DS.attr 'number'
  maxidle: DS.attr 'number'
  # sqlserver
  # postgres
  # mysql
  # ldap
  server: DS.attr 'string'
  port: DS.attr 'number'
  # soap
  # sqlserver
  # postgres
  # mysql
  # mongodb
  # ldap
  username: DS.attr 'string'
  password: DS.attr 'string'
  # ldap
  use_tls: DS.attr 'boolean'
  encoded_certificate: DS.attr 'string'
  encoded_private_key: DS.attr 'string'
  server_name: DS.attr 'string'
  private_key_password: DS.attr 'string'
  # script
  interpreter: DS.attr 'string'
  filepath: DS.attr 'string'
  script: DS.attr 'string'
  # push
  publish_endpoint: DS.attr 'boolean'

  # Relationships
  headers: DS.hasMany 'remote-endpoint-header',
    async: false
    stains: true
    embedded: true
  query: DS.hasMany 'remote-endpoint-query-parameter',
    async: false
    stains: true
    embedded: true
  hosts: DS.hasMany 'remote-endpoint-host',
    async: false
    stains: true
    embedded: true
  push_platforms: DS.hasMany 'remote-endpoint-push-platform',
    async: false
    stains: true
    embedded: true

  # Computed
  platform: Ember.computed 'type', ->
    type = @get 'type'
    RemoteEndpointLike.types.findBy 'value', type
  platformName: Ember.computed 'platform.name', ->
    @get 'platform.name'
  isHttp: Ember.computed 'platform.slug', ->
    @get('platform.slug') == 'http'
  isMongo: Ember.computed 'platform.slug', ->
    @get('platform.slug') == 'mongodb'
  isPush: Ember.computed 'platform.slug', ->
    @get('platform.slug') == 'push'
  statusType: Ember.computed 'status', ->
    status = @get 'status'
    RemoteEndpointLike.statusTypes.findBy 'value', status?.underscore()
  statusTypeName: Ember.computed.alias 'statusType.name'
  statusIsSuccess: Ember.computed 'statusType.slug', ->
    @get('statusType.slug') is 'success'
  statusIsError: Ember.computed 'statusType.slug', ->
    @get('statusType.slug') is 'failed'
  statusIsPending: Ember.computed 'statusType.slug', ->
    @get('statusType.slug') is 'pending'
  statusIsProcessing: Ember.computed 'statusType.slug', ->
    @get('statusType.slug') is 'processing'
  authSchemeType: Ember.computed 'auth_scheme', ->
    scheme = @get 'auth_scheme'
    RemoteEndpointLike.authSchemes.findBy 'value', scheme
  location: Ember.computed 'url', 'server', 'hosts.[]', ->
    location = @get('url') or @get('server')
    location = @get('hosts').map((host) -> host.get 'host')?.join(' / ') if @get 'isMongo'
    location
  sslModeType: Ember.computed 'sslmode', ->
    mode = @get 'sslmode'
    RemoteEndpointLike.sslModes.findBy 'value', mode
  sslModeTypeName: Ember.computed 'sslModeType.name', ->
    @get 'sslModeType.name'

# Declare available types and their human-readable names
types = 'http soap sqlserver postgres mysql mongodb ldap script store push'.split(' ').map (type) ->
  name: t "types.remote-endpoint.#{type}"
  slug: type
  value: type

statusTypes = 'success failed pending processing'.split(' ').map (type) ->
  name: t "types.remote-endpoint.status-types.#{type}"
  slug: type
  value: type.underscore()

sslModes = 'disable allow prefer require'.split(' ').map (mode) ->
  name: t "types.remote-endpoint.ssl-modes.#{mode}"
  slug: mode
  value: mode

authSchemes = 'basic wsse'.split(' ').map (scheme) ->
  name: t "types.remote-endpoint.auth-schemes.#{scheme}"
  slug: scheme
  value: scheme

interpreters = [
  name: 'sh'
  os: 'darwin'
  value: 'sh'
,
  name: 'sh'
  os: 'linux'
  value: 'sh'
,
  name: 'bash'
  os: 'linux'
  value: 'bash'
,
  name: 'cmd.exe'
  os: 'windows'
  value: 'cmd.exe'
]

RemoteEndpointLike.reopenClass
  types: types
  statusTypes: statusTypes
  sslModes: sslModes
  authSchemes: authSchemes
  interpreters: interpreters

`export default RemoteEndpointLike`
