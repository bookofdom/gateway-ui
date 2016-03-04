`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Model from './model'`

ScratchPad = Model.extend
  name: DS.attr 'string'
  code: DS.attr 'string'
  codeDefaults:
    http: 'request = new AP.HTTP.Request();'
    sqlserver: 'request = new AP.SQLServer.Request();'
    mysql: 'request = new AP.MySQL.Request();'
    postgres: 'request = new AP.Postgres.Request();'
    mongodb: 'request = new AP.Mongo.Request();'
    script: 'request = new AP.Script.Request();'
    soap: 'request = new AP.SOAP.Request();'

  # Relationships
  environment_datum: DS.belongsTo 'remote-endpoint-environment-datum', async: true

  codeDefaultObserver: Ember.observer 'environment_datum', ->
    if @get 'isNew'
      type = @get 'environment_datum.remote_endpoint.type'
      @set('code', @get('codeDefaults')[type])

  execute: ->
    adapter = @container.lookup 'adapter:scratch-pad'
    adapter.execute @

`export default ScratchPad`
