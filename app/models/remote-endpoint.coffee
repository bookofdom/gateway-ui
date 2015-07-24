`import DS from 'ember-data'`
`import Model from './model'`
`import t from '../helpers/i18n'`

RemoteEndpoint = Model.extend
  type: DS.attr 'string', defaultValue: 'http'

  name: DS.attr 'string'
  codename: DS.attr 'string'
  description: DS.attr 'string'

  # sqlserver
  server: DS.attr 'string'
  port: DS.attr 'number'
  username: DS.attr 'string'
  password: DS.attr 'string'
  database: DS.attr 'string'
  schema: DS.attr 'string'
  transactions: DS.attr 'boolean'

  # http
  url: DS.attr 'string'
  method: DS.attr 'string'

  # Computed
  platform: Ember.computed 'type', ->
    type = @get 'type'
    RemoteEndpoint.types.findBy 'value', type
  platformName: Ember.computed 'platform.name', ->
    @get 'platform.name'
  isHttp: Ember.computed 'platform.slug', ->
    @get('platform.slug') == 'http'

  # Relationships
  api: DS.belongsTo 'api', async: true
  headers: DS.hasMany 'remote-endpoint-header'
  query: DS.hasMany 'remote-endpoint-query-parameter'
  environment_data: DS.hasMany 'remote-endpoint-environment-datum'

  # manually manage relationship dirty
  environmentDataDirty: Ember.computed 'environment_data.@each.isDirty', ->
    @get('environment_data').filterBy('isDirty', true).get('length')
  headersDirty: Ember.computed 'headers.@each.isDirty', ->
    @get('headers').filterBy('isDirty', true).get('length')
  queryDirty: Ember.computed 'query.@each.isDirty', ->
    @get('query').filterBy('isDirty', true).get('length')
  relationshipsDirty: Ember.computed 'environmentDataDirty', 'headersDirty', 'queryDirty', ->
    @get('environmentDataDirty') or @get('headersDirty') or @get('queryDirty')
  relationshipsDirtyChange: Ember.observer 'relationshipsDirty', ->
    @send 'becomeDirty' if @get 'relationshipsDirty'
  onInit: Ember.on 'init', ->
    Ember.run.once => @get 'relationshipsDirty'

# Declare available types and their human-readable names
types = 'http sqlserver'.split(' ').map (type) ->
  name: t "types.remote-endpoint.#{type}"
  slug: type
  value: type

RemoteEndpoint.reopenClass
  types: types

`export default RemoteEndpoint`
