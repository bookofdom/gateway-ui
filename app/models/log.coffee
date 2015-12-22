`import DS from 'ember-data'`
`import Model from './model'`

Log = Model.extend
  body: DS.attr 'string'
  lines: DS.attr 'string', defaultValue: -> ''
  buffer: DS.attr 'array', defaultValue: -> []

  # Relationships
  api: DS.belongsTo 'api', async: false
  proxy_endpoint: DS.belongsTo 'proxy-endpoint', async: false

  # Get the buffer at least once, otherwise the buffer observer won't be called.
  #startBuffer: Ember.on 'init', -> @get 'buffer.length'

  # Rate-limits log updates to once per second.
  # TODO:  does this belong in the controller?
  bufferObserver: Ember.observer 'buffer.length', ->
    Ember.run.throttle @, @handleBuffer, 1000, false

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
