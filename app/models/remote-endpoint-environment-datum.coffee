`import DS from 'ember-data'`

RemoteEndpointEnvironmentDatum = DS.Model.extend
  url: DS.attr 'string'
  environment: DS.belongsTo 'environment', async: true
  remote_endpoint: DS.belongsTo 'remote-endpoint'
  # manual relationship dirty
  environmentDirty: Ember.computed 'environment.@each', ->
    original = @get('_data.environment.id') or null
    current = @get('environment.id') or null
    original != current
  relationshipsDirty: Ember.computed 'environmentDirty', ->
    @get('environmentDirty')
  relationshipsDirtyChange: Ember.observer 'relationshipsDirty', ->
    @send 'becomeDirty' if @get 'relationshipsDirty'
  onInit: Ember.on 'init', ->
    Ember.run.once => @get 'relationshipsDirty'
  toJSON: ->
    environment_id: @get 'environment.id'
    data:
      url: @get 'url'

`export default RemoteEndpointEnvironmentDatum`
