`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

headerIdCounter = 1
queryIdCounter = 1
hostIdCounter = 1

RemoteEndpointSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    headers:
      serialize: false
      deserialize: 'records'
    query:
      serialize: false
      deserialize: 'records'
    environment_data:
      embedded: 'always'
    hosts:
      embedded: 'always'
  normalize: (type, hash, property) ->
    switch hash.type
      when 'http'
        # `data` is reserved in Ember, so transform into `url` and `method`
        hash.url = hash.data.url
        hash.method = hash.data.method
        @normalizeHeaders hash
        @normalizeQuery hash
        @normalizeEnvironmentData hash
        @normalizeEnvironmentDataLinks hash
      when 'soap'
        hash.wsdl = hash.data.wsdl
        hash.service_name = hash.data.service_name
        hash.url = hash.data.url
        hash.auth_scheme =
          if hash.data.basic_auth_credentials? then 'basic'
          else if hash.data.wsse_password_credentials? then 'wsse'
        switch hash.auth_scheme
          when 'basic'
            hash.username = hash.data.basic_auth_credentials.username
            hash.password = hash.data.basic_auth_credentials.password
          when 'wsse'
            hash.username = hash.data.wsse_password_credentials.username
            hash.password = hash.data.wsse_password_credentials.password
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
        @normalizeHosts hash
    @_super.apply @, arguments
  normalizeHeaders: (hash) ->
    hash.headers = []
    hash.data.headers ?= {}
    for key, value of hash.data.headers
      hash.headers.push
        id: headerIdCounter++
        name: key
        value: value
    hash
  normalizeQuery: (hash) ->
    hash.query = []
    hash.data.query ?= {}
    for key, value of hash.data.query
      hash.query.push
        id: queryIdCounter++
        name: key
        value: value
    hash
  normalizeHosts: (hash) ->
    hash.hosts = []
    hash.data.config.hosts ?= []
    for host in hash.data.config.hosts
      hash.hosts.push
        id: hostIdCounter++
        host: host.host
        port: host.port
    hash
  # Adds ephemeral IDs to embedded environment data records, since IDs are required.
  normalizeEnvironmentData: (hash) ->
    datumIdCounter = parseInt(hash.id, 10) * 10000
    hash.environment_data ?= []
    for datum in hash.environment_data
      datum.id = datumIdCounter++
    hash
  # Adds links to embedded environment data
  normalizeEnvironmentDataLinks: (hash) ->
    if hash.environment_data
      for datum in hash.environment_data
        if datum.environment_id
          datum.links =
            environment: "/apis/#{hash.api_id}/environments/#{datum.environment_id}"
    hash
  serialize: (model) ->
    serialized = @_super.apply @, arguments
    switch serialized.type
      when 'http'
        serialized.data =
          url: serialized.url
          method: serialized.method
          headers: @serializeHeaders model
          query: @serializeQuery model
      when 'soap'
        serialized.data =
          wsdl: serialized.wsdl
          service_name: serialized.service_name
          url: serialized.url
          basic_auth_credentials: if serialized.auth_scheme is 'basic'
            username: serialized.username
            password: serialized.password
          wsse_password_credentials: if serialized.auth_scheme is 'wsse'
            username: serialized.username
            password: serialized.password
      when 'sqlserver'
        serialized.data =
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
        serialized.data =
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
        serialized.data =
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
        serialized.data =
          config:
            hosts: serialized.hosts
            database: serialized.database
            username: serialized.username
            password: serialized.password
          limit: serialized.limit
        delete serialized.hosts
    serialized
  serializeHeaders: (model) ->
    headers = {}
    model.get('headers').forEach (header) ->
      headers[header.get 'name'] = header.get 'value'
    headers
  serializeQuery: (model) ->
    query = {}
    model.get('query').forEach (param) ->
      query[param.get 'name'] = param.get 'value'
    query

`export default RemoteEndpointSerializer`
