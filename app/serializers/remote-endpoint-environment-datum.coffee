`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

headerIdCounter = 1

RemoteEndpointEnvironmentDatumSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    headers:
      #embedded: 'always'
      serialize: false
      deserialize: 'records'
  normalize: (type, hash, property) ->
    # `data` is reserved in Ember, so transform into `url` and `method`
    hash.url = hash.data.url
    hash.method = hash.data.method
    @normalizeHeaders hash
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
  serialize: (model) ->
    serialized = @_super.apply @, arguments
    serialized.data =
      url: model.get 'url'
      method: model.get 'method'
      headers: @serializeHeaders model
    serialized
  serializeHeaders: (model) ->
    headers = {}
    model.get('headers').forEach (header) ->
      headers[header.get 'name'] = header.get 'value'
    headers

`export default RemoteEndpointEnvironmentDatumSerializer`
