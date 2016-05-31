HanaRemoteEndpointSerializer =
  normalize: (hash) ->
    hash.server = hash.data.config.host
    hash.port = hash.data.config.port
    hash.username = hash.data.config.user
    hash.password = hash.data.config.password

  serialize: (serialized) ->
    serialized.data = Ember.merge serialized.data,
      config:
        host: serialized.server
        port: serialized.port
        user: serialized.username
        password: serialized.password

`export default HanaRemoteEndpointSerializer`
