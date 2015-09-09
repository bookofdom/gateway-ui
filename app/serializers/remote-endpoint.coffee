`import DS from 'ember-data'`
`import RemoteEndpointLikeSerializer from './remote-endpoint-like'`

RemoteEndpointSerializer = RemoteEndpointLikeSerializer.extend
  normalize: (type, hash, property) ->
    switch hash.type
      when 'http'
        # `data` is reserved in Ember, so transform into `url` and `method`
        hash.url = hash.data.url
        hash.method = hash.data.method
      when 'soap'
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
      when 'sqlserver'
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
      when 'postgres'
        hash.server = hash.data.config.host
        hash.database = hash.data.config.dbname
        hash.username = hash.data.config.user
        hash.port = hash.data.config.port
        hash.password = hash.data.config.password
        hash.sslmode = hash.data.config.sslmode
        hash.transactions = hash.data.transactions
        hash.maxopen = hash.data.maxOpenConn
        hash.maxidle = hash.data.maxIdleConn
      when 'mysql'
        hash.server = hash.data.config.server
        hash.database = hash.data.config.dbname
        hash.username = hash.data.config.username
        hash.timeout = parseInt(hash.data.config.timeout, 10)
        hash.port = hash.data.config.port
        hash.password = hash.data.config.password
        hash.transactions = hash.data.transactions
        hash.maxopen = hash.data.maxOpenConn
        hash.maxidle = hash.data.maxIdleConn
      when 'mongodb'
        hash.database = hash.data.config.database
        hash.username = hash.data.config.username
        hash.password = hash.data.config.password
        hash.limit = hash.data.limit
    @_super.apply @, arguments
  serialize: (model) ->
    serialized = @_super.apply @, arguments
    switch serialized.type
      when 'http'
        serialized.data = Ember.merge serialized.data,
          url: serialized.url
          method: serialized.method
      when 'soap'
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
      when 'sqlserver'
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
      when 'postgres'
        serialized.data = Ember.merge serialized.data,
          config:
            host: serialized.server
            port: serialized.port
            user: serialized.username
            password: serialized.password
            dbname: serialized.database
            sslmode: serialized.sslmode
          transactions: serialized.transactions
          maxIdleConn: serialized.maxidle
          maxOpenConn: serialized.maxopen
      when 'mysql'
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
      when 'mongodb'
        serialized.data = Ember.merge serialized.data,
          config:
            hosts: serialized.hosts
            database: serialized.database
            username: serialized.username
            password: serialized.password
          limit: serialized.limit
        delete serialized.hosts
    serialized

`export default RemoteEndpointSerializer`
