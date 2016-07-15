ScriptRemoteEndpointSerializer =
  normalize: (hash) ->
    hash.interpreter = hash.data.config.interpreter
    hash.timeout = hash.data.config.timeout
    hash.filepath = hash.data.config.filepath
    hash.script = hash.data.config.script

  serialize: (serialized) ->
    serialized.data = Ember.merge serialized.data,
      config:
        interpreter: serialized.interpreter
        timeout: serialized.timeout
        filepath: serialized.filepath
        script: serialized.script
    delete serialized.hosts

`export default ScriptRemoteEndpointSerializer`
