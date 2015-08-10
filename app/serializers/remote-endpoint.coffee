`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

headerIdCounter = 1
queryIdCounter = 1
hostIdCounter = 1

RemoteEndpointSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    headers:
      #embedded: 'always'
      serialize: false
      deserialize: 'records'
    query:
      #embedded: 'always'
      serialize: false
      deserialize: 'records'
    hosts:
      serialize: false
      deserialize: 'records'
    environment_data:
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
      when 'sqlserver'
        hash.server = hash.data.config.server
        hash.port = hash.data.config.port
        hash.username = hash.data.config['user id']
        hash.password = hash.data.config.password
        hash.database = hash.data.config.database
        hash.schema = hash.data.config.schema
        hash.timeout = hash.data.config['connection timeout']
        hash.transactions = hash.data.transactions
        hash.maxopen = hash.data.maxOpenConn
        hash.maxidle = hash.data.maxIdleConn
      when 'mongodb'
        @normalizeHosts hash
        hash.database = hash.data.config.database
        hash.username = hash.data.config.username
        hash.password = hash.data.config.password
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
      when 'mongodb'
        serialized.data =
          config:
            hosts: @serializeHosts model
            database: serialized.database
            username: serialized.username
            password: serialized.password
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
  serializeHosts: (model) ->
    hosts = []
    model.get('hosts').forEach (param) ->
      port = param.get 'port'
      port = parseInt(port, 10) if port?
      hosts.push
        host: param.get 'host'
        port: port
    hosts

`export default RemoteEndpointSerializer`
