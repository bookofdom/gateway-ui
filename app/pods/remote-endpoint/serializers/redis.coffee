RedisRemoteEndpointSerializer =
  normalize: (hash) ->
    hash.username   = hash.data.config.username
    hash.password   = hash.data.config.password
    hash.server       = hash.data.config.host
    hash.port       = hash.data.config.port
    hash.database   = hash.data.config.database
    hash.maxopen  = hash.data.maxactive
    hash.maxidle    = hash.data.maxidle
    
  serialize: (serialized) -> 
    serialized.data = Ember.merge serialized.data,
      config:
        username: serialized.username
        password: serialized.password
        host:     serialized.server
        port:     serialized.port
        database: serialized.database
      maxactive: serialized.maxopen
      maxidle: serialized.maxidle

`export default RedisRemoteEndpointSerializer`
