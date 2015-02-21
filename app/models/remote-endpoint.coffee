`import DS from 'ember-data'`
`import Model from './model'`

RemoteEndpoint = Model.extend
  name: DS.attr 'string'
  type: DS.attr 'string', defaultValue: 'http'
  description: DS.attr 'string'
  url: DS.attr 'string'
  method: DS.attr 'string'
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

`export default RemoteEndpoint`
