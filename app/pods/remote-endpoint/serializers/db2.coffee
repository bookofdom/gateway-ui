Db2EndpointSerializer =
  normalize: (hash) ->
    hash.database = hash.data.config.dbname
    hash.server = hash.data.config.host
    hash.port = hash.data.config.port
    hash.protocol = hash.data.config.protocol
    hash.username = hash.data.config.user
    hash.password = hash.data.config.password
    hash.transactions = hash.data.transactions

  serialize: (serialized) ->
    serialized.data = Ember.merge serialized.data,
      config:
        dbname: serialized.database
        host: serialized.server
        port: serialized.port
        protocol: serialized.protocol
        user: serialized.username
        password: serialized.password
      transactions: serialized.transactions

`export default Db2EndpointSerializer`
