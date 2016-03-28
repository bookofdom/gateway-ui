LdapRemoteEndpointSerializer =
  normalize: (hash) ->
    hash.username = hash.data.username
    hash.password = hash.data.password
    hash.server = hash.data.host
    hash.port = hash.data.port
    hash.use_tls = hash.data.use_tls
    hash.encoded_certificate = hash.data.tls?.encoded_certificate
    hash.encoded_private_key = hash.data.tls?.encoded_private_key
    hash.server_name = hash.data.tls?.server_name
    hash.private_key_password = hash.data.tls?.private_key_password

  serialize: (serialized) ->
    serialized.data = Ember.merge serialized.data,
      tls: if serialized.use_tls
        encoded_certificate: serialized.encoded_certificate
        encoded_private_key: serialized.encoded_private_key
        server_name: serialized.server_name
        private_key_password: serialized.private_key_password
      username: serialized.username
      password: serialized.password
      host: serialized.server
      port: serialized.port
      use_tls: serialized.use_tls

`export default LdapRemoteEndpointSerializer`
