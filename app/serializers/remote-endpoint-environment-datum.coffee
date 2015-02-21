`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

# offset by since remote endpoints also have headers...
# if their ephemeral ID counters started at the same number,
# there would be ID colisions
headerIdCounter = 1000000
queryIdCounter = 1000000

RemoteEndpointEnvironmentDatumSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    headers:
      #embedded: 'always'
      serialize: false
      deserialize: 'records'
    query:
      #embedded: 'always'
      serialize: false
      deserialize: 'records'
  normalize: (type, hash, property) ->
    # `data` is reserved in Ember, so transform into `url` and `method`
    hash.url = hash.data.url
    hash.method = hash.data.method
    @normalizeHeaders hash
    @normalizeQuery hash
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
  serialize: (model) ->
    serialized = @_super.apply @, arguments
    serialized.data =
      url: model.get 'url'
      method: model.get 'method'
      headers: @serializeHeaders model
      query: @serializeQuery model
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

`export default RemoteEndpointEnvironmentDatumSerializer`
