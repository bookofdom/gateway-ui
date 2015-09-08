`import DS from 'ember-data'`
`import RemoteEndpointLikeSerializer from './remote-endpoint-like'`

RemoteEndpointEnvironmentDatumSerializer = RemoteEndpointLikeSerializer.extend DS.EmbeddedRecordsMixin,
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
        id: @generateId()
        name: key
        value: value
    hash
  normalizeQuery: (hash) ->
    hash.query = []
    hash.data.query ?= {}
    for key, value of hash.data.query
      hash.query.push
        id: @generateId()
        name: key
        value: value
    hash
  serialize: (model) ->
    serialized = @_super.apply @, arguments
    serialized.environment_id = parseInt(serialized.environment_id, 10) if serialized.environment_id?
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
