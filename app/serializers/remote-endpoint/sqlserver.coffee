SqlserverRemoteEndpointSerializer =
  normalize: (hash) ->
    hash.server = hash.data.config.server
    hash.database = hash.data.config.database
    hash.username = hash.data.config['user id']
    hash.timeout = hash.data.config['connection timeout']
    hash.schema = hash.data.config.schema
    hash.port = hash.data.config.port
    hash.password = hash.data.config.password
    hash.transactions = hash.data.transactions
    hash.maxopen = hash.data.maxOpenConn
    hash.maxidle = hash.data.maxIdleConn

  serialize: (serialized) ->
    serialized.data = Ember.merge serialized.data,
      config:
        server: serialized.server
        port: serialized.port
        'user id': serialized.username
        password: serialized.password
        database: serialized.database
        schema: serialized.schema
        'connection timeout': serialized.timeout
      transactions: serialized.transactions
      maxIdleConn: serialized.maxidle
      maxOpenConn: serialized.maxopen

`export default SqlserverRemoteEndpointSerializer`
