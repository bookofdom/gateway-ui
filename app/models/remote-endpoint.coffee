`import DS from 'ember-data'`

RemoteEndpoint = DS.Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
  type: DS.attr 'string', defaultValue: 'http'
  api: DS.belongsTo 'api', async: true
  environment_data: DS.hasMany 'remote-endpoint-environment-datum'
  # manually manage relationship dirty
  environmentDataDirty: Ember.computed 'environment_data.@each.isDirty', ->
    @get('environment_data').filterBy('isDirty', true).get('length')
  relationshipsDirty: Ember.computed 'environmentDataDirty', ->
    @get('environmentDataDirty')
  relationshipsDirtyChange: Ember.observer 'relationshipsDirty', ->
    @send 'becomeDirty' if @get 'relationshipsDirty'
  onInit: Ember.on 'init', ->
    Ember.run.once => @get 'relationshipsDirty'

`export default RemoteEndpoint`
