`import DS from 'ember-data'`
`import Model from './model'`

RemoteEndpointEnvironmentDatum = Model.extend
  url: DS.attr 'string'
  method: DS.attr 'string'

  # Relationships
  environment: DS.belongsTo 'environment', async: true
  remote_endpoint: DS.belongsTo 'remote-endpoint', async: false
  headers: DS.hasMany 'remote-endpoint-header', async: false
  query: DS.hasMany 'remote-endpoint-query-parameter', async: false
  
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
