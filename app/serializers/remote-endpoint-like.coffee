`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

RemoteEndpointLikeSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    headers:
      serialize: false
      deserialize: 'records'
    query:
      serialize: false
      deserialize: 'records'
    hosts:
      embedded: 'always'
    environment_data:
      embedded: 'always'

  normalize: (type, hash, property) ->
    hash.data ?= {}
    # normalize embedded resources
    hash.headers = @objectToArray hash.data.headers
    hash.query = @objectToArray hash.data.query
    hash.hosts = hash.data.config?.hosts or []
    @normalizeEnvironmentData hash
    @_super.apply @, arguments
  objectToArray: (obj={}) ->
    for key, value of obj
      name: key
      value: value
  normalizeEnvironmentData: (hash) ->
    hash.environment_data ?= []
    datum.type = hash.type for datum in hash.environment_data

  serialize: (model) ->
    serialized = @_super.apply @, arguments
    serialized.data =
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

`export default RemoteEndpointLikeSerializer`
