SmtpRemoteEndpointSerializer =
  normalize: (hash) ->
    hash.username = hash.data.config.username
    hash.password = hash.data.config.password
    hash.host     = hash.data.config.host
    hash.port     = hash.data.config.port
    hash.sender   = hash.data.config.sender
  serialize: (serialized) ->
    serialized.data = Ember.merge serialized.data,
      config:
        username: serialized.username
        password: serialized.password
        host: serialized.host
        port: serialized.port
        sender: serialized.sender
    
`export default SmtpRemoteEndpointSerializer`
