`import DS from 'ember-data'`
`import Model from './model'`
`import t from '../helpers/i18n'`

RemoteEndpoint = Model.extend
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
  endpoint_name: DS.attr 'string'
  action_name: DS.attr 'string'

  # http
  # soap
  url: DS.attr 'string'

  # sqlserver
  schema: DS.attr 'string'

  # postgres
  sslmode: DS.attr 'string', defaultValue: 'prefer'

  # sqlserver
  # postgres
  # mysql
  server: DS.attr 'string'
  port: DS.attr 'number'
  database: DS.attr 'string'
  transactions: DS.attr 'boolean'
  timeout: DS.attr 'number'
  maxopen: DS.attr 'number'
  maxidle: DS.attr 'number'

  # mongodb
  limit: DS.attr 'number', defaultValue: 16

  # soap
  # sqlserver
  # postgres
  # mysql
  # mongodb
  username: DS.attr 'string'
  password: DS.attr 'string'

  # Relationships
  api: DS.belongsTo 'api', async: true
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
  environment_data: DS.hasMany 'remote-endpoint-environment-datum',
    async: false
    embedded: true

  # Computed
  platform: Ember.computed 'type', ->
    type = @get 'type'
    RemoteEndpoint.types.findBy 'value', type
  platformName: Ember.computed 'platform.name', ->
    @get 'platform.name'
  isHttp: Ember.computed 'platform.slug', ->
    @get('platform.slug') == 'http'
  isMongo: Ember.computed 'platform.slug', ->
    @get('platform.slug') == 'mongodb'
  statusType: Ember.computed 'status', ->
    status = @get 'status'
    RemoteEndpoint.statusTypes.findBy 'value', status
  isSuccess: Ember.computed 'statusType.slug', ->
    @get('statusType.slug') is 'Success'
  isError: Ember.computed 'statusType.slug', ->
    @get('statusType.slug') is 'Error'
  isPending: Ember.computed 'statusType.slug', ->
    @get('statusType.slug') is 'Pending'
  isProcessing: Ember.computed 'statusType.slug', ->
    @get('statusType.slug') is 'Processing'
  location: Ember.computed 'url', 'server', ->
    location = @get('url') or @get('server')
    location = @get('hosts').map((host) -> host.get 'host')?.join(' / ') if @get 'isMongo'
    location
  sslModeType: Ember.computed 'sslmode', ->
    mode = @get 'sslmode'
    RemoteEndpoint.sslModes.findBy 'value', mode
  sslModeTypeName: Ember.computed 'sslModeType.name', ->
    @get 'sslModeType.name'

# Declare available types and their human-readable names
types = 'http soap sqlserver postgres mysql mongodb'.split(' ').map (type) ->
  name: t "types.remote-endpoint.#{type}"
  slug: type
  value: type

statusTypes = 'success error pending processing'.split(' ').map (type) ->
  name: t "types.remote-endpoint.status-types.#{type}"
  slug: type
  value: type

sslModes = 'disable allow prefer require'.split(' ').map (mode) ->
  name: t "types.remote-endpoint.ssl-modes.#{mode}"
  slug: mode
  value: mode

RemoteEndpoint.reopenClass
  types: types
  sslModes: sslModes

`export default RemoteEndpoint`
