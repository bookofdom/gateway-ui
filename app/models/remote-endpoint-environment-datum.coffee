`import DS from 'ember-data'`
`import Model from './model'`

RemoteEndpointEnvironmentDatum = Model.extend
  url: DS.attr 'string'
  method: DS.attr 'string'
  environment: DS.belongsTo 'environment', async: true
  remote_endpoint: DS.belongsTo 'remote-endpoint'
  headers: DS.hasMany 'remote-endpoint-header'
  # manual relationship dirty
  environmentDirty: Ember.computed 'environment.@each', ->
    original = @get('_data.environment.id') or null
    current = @get('environment.id') or null
    original != current
  headersDirty: Ember.computed 'headers.@each.isDirty', ->
    @get('headers').filterBy('isDirty', true).get('length')
  relationshipsDirty: Ember.computed 'environmentDirty', 'headersDirty', ->
    @get('environmentDirty') or @get('headersDirty')
  relationshipsDirtyChange: Ember.observer 'relationshipsDirty', ->
    @send 'becomeDirty' if @get 'relationshipsDirty'
  onInit: Ember.on 'init', ->
    Ember.run.once => @get 'relationshipsDirty'
  reload: ->
    # no op reload, since environment data are embedded records
    new Ember.RSVP.Promise (resolve, reject) => resolve @
  save: ->
    # delegate save to parent remote endpoint and then
    # "rollback" to now-saved embedded record
    @get('remote_endpoint').save().then (=>
      @rollback()
    ), (=>)
  deleteRecord: ->
    @_super.apply @, arguments
    @store.dematerializeRecord @
  destroyRecord: ->
    @deleteRecord()
    remoteEndpoint = @get 'remote_endpoint'
    remoteEndpoint.save().then (->
      remoteEndpoint.rollback()
    ), (=>)

`export default RemoteEndpointEnvironmentDatum`
