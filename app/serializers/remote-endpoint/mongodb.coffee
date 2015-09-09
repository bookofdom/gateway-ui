MongodbRemoteEndpointSerializer =
  normalize: (hash) ->
    hash.database = hash.data.config.database
    hash.username = hash.data.config.username
    hash.password = hash.data.config.password
    hash.limit = hash.data.limit

  serialize: (serialized) ->
    serialized.data = Ember.merge serialized.data,
      config:
        hosts: serialized.hosts
        database: serialized.database
        username: serialized.username
        password: serialized.password
      limit: serialized.limit
    delete serialized.hosts

`export default MongodbRemoteEndpointSerializer`
