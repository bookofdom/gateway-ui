`import DS from 'ember-data'`
`import Model from './model'`

Log = Model.extend
  body: DS.attr 'string'

  # Relationships
  api: DS.belongsTo 'api', async: false
  proxy_endpoint: DS.belongsTo 'proxy-endpoint', async: false

  pushLogLine: (line) ->
    body = @get 'body'
    body = [body, line].join ''
    @set 'body', body

  enableStreaming: ->
    adapter = @store.adapterFor 'log'
    adapter.enableStreaming @

  disableStreaming: ->
    adapter = @store.adapterFor 'log'
    adapter.disableStreaming()

`export default Log`
