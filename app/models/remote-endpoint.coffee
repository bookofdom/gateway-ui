`import DS from 'ember-data'`
`import Model from './model'`
`import t from '../helpers/i18n'`

RemoteEndpoint = Model.extend
  type: DS.attr 'string', defaultValue: 'http'

  name: DS.attr 'string'
  codename: DS.attr 'string'
  description: DS.attr 'string'

  # http
  url: DS.attr 'string'
  method: DS.attr 'string'

  # sqlserver
  schema: DS.attr 'string'

  # postgres
  sslmode: DS.attr 'string', defaultValue: 'prefer'

  # sqlserver
  # postgres
  # mysql
  server: DS.attr 'string'
  port: DS.attr 'number'
  username: DS.attr 'string'
  password: DS.attr 'string'
  database: DS.attr 'string'
  transactions: DS.attr 'boolean'
  timeout: DS.attr 'number'
  maxopen: DS.attr 'number'
  maxidle: DS.attr 'number'

  # mongodb
  limit: DS.attr 'number', defaultValue: 16

  # Relationships
  api: DS.belongsTo 'api', async: true
  headers: DS.hasMany 'remote-endpoint-header', async: false
  query: DS.hasMany 'remote-endpoint-query-parameter', async: false
  environment_data: DS.hasMany 'remote-endpoint-environment-datum', async: false
  hosts: DS.hasMany 'remote-endpoint-host', async: false

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
  location: Ember.computed 'url', 'server', ->
    location = @get('url') or @get('server')
    location = @get('hosts').map((host) -> host.get 'host')?.join(' / ') if @get 'isMongo'
    location
  sslModeType: Ember.computed 'sslmode', ->
    mode = @get 'sslmode'
    RemoteEndpoint.sslModes.findBy 'value', mode
  sslModeTypeName: Ember.computed 'sslModeType.name', ->
    @get 'sslModeType.name'

  # manually manage relationship dirty
  environmentDataDirty: Ember.computed 'environment_data.@each.hasDirtyAttributes', ->
    @get('environment_data').filterBy('hasDirtyAttributes', true).get('length')
  headersDirty: Ember.computed 'headers.@each.hasDirtyAttributes', ->
    @get('headers').filterBy('hasDirtyAttributes', true).get('length')
  queryDirty: Ember.computed 'query.@each.hasDirtyAttributes', ->
    @get('query').filterBy('hasDirtyAttributes', true).get('length')
  hostsDirty: Ember.computed 'hosts.@each.hasDirtyAttributes', ->
    @get('hosts').filterBy('hasDirtyAttributes', true).get('length')
  relationshipsDirty: Ember.computed 'environmentDataDirty', 'headersDirty', 'queryDirty', 'hostsDirty', ->
    @get('environmentDataDirty') or @get('headersDirty') or @get('queryDirty') or @get('hostsDirty')
  relationshipsDirtyChange: Ember.observer 'relationshipsDirty', ->
    @send 'becomeDirty' if @get 'relationshipsDirty'
  onInit: Ember.on 'init', ->
    Ember.run.once => @get 'relationshipsDirty'

# Declare available types and their human-readable names
types = 'http sqlserver postgres mysql mongodb'.split(' ').map (type) ->
  name: t "types.remote-endpoint.#{type}"
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
