SmtpRemoteEndpointSerializer =
  normalize: (hash) ->
    hash.username = hash.data.config.user
    hash.password = hash.data.config.password
    hash.server   = hash.data.config.host
    hash.port     = hash.data.config.port
    hash.sender   = hash.data.config.sender
  serialize: (serialized) ->
    serialized.data = Ember.merge serialized.data,
      config:
        user: serialized.username
        password: serialized.password
        host: serialized.server
        port: serialized.port
        sender: serialized.sender
    
`export default SmtpRemoteEndpointSerializer`
