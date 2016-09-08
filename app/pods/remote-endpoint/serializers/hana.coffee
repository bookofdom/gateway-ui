HanaRemoteEndpointSerializer =
  normalize: (hash) ->
    hash.server = hash.data.config.host
    hash.port = hash.data.config.port
    hash.username = hash.data.config.user
    hash.password = hash.data.config.password
    hash.transactions = hash.data.transactions
    hash.maxopen = hash.data.maxOpenConn
    hash.maxidle = hash.data.maxIdleConn

  serialize: (serialized) ->
    serialized.data = Ember.merge serialized.data,
      config:
        host: serialized.server
        port: serialized.port
        user: serialized.username
        password: serialized.password
      transactions: serialized.transactions
      maxIdleConn: serialized.maxidle
      maxOpenConn: serialized.maxopen

`export default HanaRemoteEndpointSerializer`
