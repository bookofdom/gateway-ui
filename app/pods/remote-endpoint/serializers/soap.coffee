SoapRemoteEndpointSerializer =
  normalize: (hash) ->
    hash.wsdl = hash.data.wsdl
    hash.service_name = hash.data.serviceName
    hash.url = hash.data.url
    hash.auth_scheme =
      if hash.data.basicAuthCredentials? then 'basic'
      else if hash.data.wssePasswordCredentials? then 'wsse'
    switch hash.auth_scheme
      when 'basic'
        hash.username = hash.data.basicAuthCredentials.username
        hash.password = hash.data.basicAuthCredentials.password
      when 'wsse'
        hash.username = hash.data.wssePasswordCredentials.username
        hash.password = hash.data.wssePasswordCredentials.password

  serialize: (serialized) ->
    serialized.data = Ember.merge serialized.data,
      wsdl: serialized.wsdl
      serviceName: serialized.service_name
      url: serialized.url
      basicAuthCredentials: if serialized.auth_scheme is 'basic'
        username: serialized.username
        password: serialized.password
      wssePasswordCredentials: if serialized.auth_scheme is 'wsse'
        username: serialized.username
        password: serialized.password

`export default SoapRemoteEndpointSerializer`
