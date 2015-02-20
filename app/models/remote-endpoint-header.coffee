`import DS from 'ember-data'`
`import Model from './model'`

RemoteEndpointHeader = Model.extend
  name: DS.attr 'string'
  value: DS.attr 'string'
  environment_datum: DS.belongsTo 'remote-endpoint-environment-datum'
  reload: ->
    # no op reload, since environment data are embedded records
    new Ember.RSVP.Promise (resolve, reject) => resolve @
  save: ->
    # delegate save to parent environment datum and then
    # "rollback" to now-saved embedded record
    @get('environment_datum').save().then (=>
      @rollback()
    ), (=>)
  deleteRecord: ->
    @_super.apply @, arguments
    @store.dematerializeRecord @
  destroyRecord: ->
    @deleteRecord()
    datum = @get 'environment_datum'
    datum.save().then (->
      datum.rollback()
    ), (=>)

`export default RemoteEndpointHeader`
