`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`

Log = Model.extend
  body: DS.attr 'string'
  lines: DS.attr 'string', defaultValue: -> ''
  buffer: DS.attr 'array', defaultValue: -> []

  # Relationships
  api: DS.belongsTo 'api', async: false
  proxy_endpoint: DS.belongsTo 'proxy-endpoint', async: false
  job: DS.belongsTo 'job', async: false
  timer: DS.belongsTo 'timer', async: false

  bufferTimeout: 1000

  # Rate-limits log updates to once per second.
  bufferObserver: Ember.observer 'buffer.length', ->
    bufferTimeout = @get 'bufferTimeout'
    Ember.run.throttle @, @handleBuffer, bufferTimeout, false

  handleBuffer: ->
    buffer = @get 'buffer'
    bufferLength = buffer.length
    if bufferLength
      lines = @get 'lines'
      @set 'lines', lines.concat(buffer.join '\n')
      buffer.clear()

  pushLogLine: (line) ->
    buffer = @get 'buffer'
    buffer.pushObject line

  enableStreaming: ->
    adapter = @store.adapterFor 'log'
    adapter.enableStreaming @

  disableStreaming: ->
    adapter = @store.adapterFor 'log'
    adapter.disableStreaming()

`export default Log`
