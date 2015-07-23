`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

headerIdCounter = 1
queryIdCounter = 1

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
        hash.server = hash.data.server
        hash.port = hash.data.port
        hash.username = hash.data['user id']
        hash.password = hash.data.password
        hash.database = hash.data.database
        hash.schema = hash.data.schema
        hash.transactions = hash.data.transactions
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
          url: model.get 'url'
          method: model.get 'method'
          headers: @serializeHeaders model
          query: @serializeQuery model
      when 'sqlserver'
        serialized.data =
          server: model.get 'data'
          port: model.get 'port'
          'user id': model.get 'username'
          password: model.get 'password'
          database: model.get 'database'
          schema: model.get 'schema'
          transactions: model.get 'transactions'
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
