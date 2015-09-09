MysqlRemoteEndpointSerializer =
  normalize: (hash) ->
    hash.server = hash.data.config.server
    hash.database = hash.data.config.dbname
    hash.username = hash.data.config.username
    hash.timeout = parseInt(hash.data.config.timeout, 10)
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
        username: serialized.username
        password: serialized.password
        dbname: serialized.database
        timeout: "#{serialized.timeout}s" if serialized.timeout
      transactions: serialized.transactions
      maxIdleConn: serialized.maxidle
      maxOpenConn: serialized.maxopen

`export default MysqlRemoteEndpointSerializer`
