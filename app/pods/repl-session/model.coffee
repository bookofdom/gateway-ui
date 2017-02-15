`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`

# Represents a REPL session
ReplSession = DS.Model.extend
  created: DS.attr 'date', defaultValue: -> Date.now()
  currentFrame: DS.attr 'string'

  # Relationships
  environment: DS.belongsTo 'environment', async: true

  # Computed
  frameText: Ember.computed.alias 'currentFrame.data'
  frameError: Ember.computed.equal('currentFrame.type', 'error').volatile()

  enableStreaming: ->
    adapter = @store.adapterFor 'repl-session'
    adapter.enableStreaming @

  disableStreaming: ->
    adapter = @store.adapterFor 'repl-session'
    adapter.disableStreaming()

  evaluate: (text) ->
    adapter = @store.adapterFor 'repl-session'
    adapter.evaluate text

  print: (frame) ->
    @set 'currentFrame', frame

`export default ReplSession`
