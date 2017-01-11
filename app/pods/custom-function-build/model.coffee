`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`

CustomFunctionBuild = Model.extend
  executing: DS.attr 'boolean', defaultValue: -> false
  lines: DS.attr 'string', defaultValue: -> ''
  buffer: DS.attr 'array', defaultValue: -> []
  time: DS.attr 'number', defaultValue: -> 0

  # Relationships
  custom_function: DS.belongsTo 'custom-function', async: true

  bufferTimeout: 1000

  executeBuild: ->
    adapter = Ember.getOwner(@).lookup 'adapter:custom-function-build'
    adapter.executeBuild @

  # Rate-limits log updates to once per second.
  bufferObserver: Ember.observer 'buffer.length', ->
    bufferTimeout = @get 'bufferTimeout'
    Ember.run.throttle @, @handleBuffer, bufferTimeout, false

  handleBuffer: ->
    buffer = @get 'buffer'
    bufferLength = buffer.length
    if bufferLength
      lines = @get 'lines'
      @set 'lines', lines.concat(buffer.join '')
      buffer.clear()

  pushLogLine: (line) ->
    buffer = @get 'buffer'
    buffer.pushObject line

`export default CustomFunctionBuild`
