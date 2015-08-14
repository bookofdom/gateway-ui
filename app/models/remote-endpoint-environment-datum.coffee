`import DS from 'ember-data'`
`import Model from './model'`

RemoteEndpointEnvironmentDatum = Model.extend
  url: DS.attr 'string'
  method: DS.attr 'string'
  environment: DS.belongsTo 'environment', async: true
  remote_endpoint: DS.belongsTo 'remote-endpoint'
  headers: DS.hasMany 'remote-endpoint-header'
  query: DS.hasMany 'remote-endpoint-query-parameter'
  # manual relationship dirty
  environmentDirty: Ember.computed 'environment.[]', ->
    original = @get('_data.environment.id') or null
    current = @get('environment.id') or null
    original != current
  headersDirty: Ember.computed 'headers.@each.hasDirtyAttributes', ->
    @get('headers').filterBy('hasDirtyAttributes', true).get('length')
  queryDirty: Ember.computed 'query.@each.hasDirtyAttributes', ->
    @get('query').filterBy('hasDirtyAttributes', true).get('length')
  relationshipsDirty: Ember.computed 'environmentDirty', 'headersDirty', 'queryDirty', ->
    @get('environmentDirty') or @get('headersDirty') or @get('queryDirty')
  relationshipsDirtyChange: Ember.observer 'relationshipsDirty', ->
    @send 'becomeDirty' if @get 'relationshipsDirty'
  onInit: Ember.on 'init', ->
    Ember.run.once => @get 'relationshipsDirty'
  reload: ->
    # delegate reload to parent remote endpoint
    @get('remote_endpoint').reload()
  save: ->
    # delegate save to parent remote endpoint and then
    # "rollback" to now-saved embedded record
    new Ember.RSVP.Promise (resolve, reject) =>
      @get('remote_endpoint').save().then (=>
        @rollback()
        resolve @
      ), (=> reject @)
  deleteRecord: ->
    @_super.apply @, arguments
    @store.dematerializeRecord @
  destroyRecord: ->
    @deleteRecord()
    @transitionTo 'loaded.saved' # clear deleted state
    remoteEndpoint = @get 'remote_endpoint'
    remoteEndpoint.save().then (->
      remoteEndpoint.rollback()
    ), (=>)

`export default RemoteEndpointEnvironmentDatum`
