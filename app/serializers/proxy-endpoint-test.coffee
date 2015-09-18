`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`
`import ProxyEndpointTest from '../models/proxy-endpoint-test'`

ProxyEndpointTestSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    headers:
      embedded: 'always'
    query:
      embedded: 'always'
  normalize: (type, hash, property) ->
    @normalizeMethods hash
    @normalizeContentType hash
    @normalizeHeaders hash
    @normalizeQuery hash
    delete hash.pairs
    @_super.apply @, arguments
  normalizeMethods: (hash) ->
    hash.methods ?= []
    hash.method = hash.methods[0]
    delete hash.methods
    hash
  normalizeContentType: (hash) ->
    hash.pairs ?= []
    hash.content_type = null
    # find a content type header
    contentType = hash.pairs.find (pair) ->
      (pair.type is 'header') and (pair.key is 'Content-Type')
    value = contentType?.value
    # If a content type header is one of the default content types, remove it from headers.
    # Default content types are always exposed via the model field content_type.
    if value in ProxyEndpointTest.contentTypes.map((type) -> type.value)
      hash.content_type = value
      hash.pairs = hash.pairs.filter (pair) ->
        !((pair.type is 'header') and (pair.key is 'Content-Type'))
    hash
  normalizeHeaders: (hash) ->
    hash.pairs ?= []
    hash.headers = hash.pairs.filter (pair) -> pair.type is 'header'
    hash.headers = hash.headers.map (header) ->
      id: header.id
      name: header.key
      value: header.value
    hash
  normalizeQuery: (hash) ->
    hash.pairs ?= []
    hash.query = hash.pairs.filter (pair) -> pair.type is 'get'
    hash.query = hash.query.map (param) ->
      id: param.id
      name: param.key
      value: param.value
    hash
  serialize: (model) ->
    serialized = @_super.apply @, arguments
    serialized.methods = if serialized.method then [serialized.method] else []
    serialized.pairs = @serializePairs model, serialized
    delete serialized.method
    delete serialized.headers
    delete serialized.query
    delete serialized.content_type
    serialized
  serializePairs: (model, serialized) ->
    pairs = []
    contentType = model.get('headers').find (header) ->
      header.get('name') is 'Content-Type'
    if serialized.content_type and !contentType
      pairs.push
        type: 'header'
        key: 'Content-Type'
        value: serialized.content_type
    model.get('headers').forEach (header) ->
      id = header.get 'id'
      id = parseInt(id, 10) if id
      pairs.push
        id: id
        type: 'header'
        key: header.get 'name'
        value: header.get 'value'
    model.get('query').forEach (param) ->
      id = param.get 'id'
      id = parseInt(id, 10) if id
      pairs.push
        id: id
        type: 'get'
        key: param.get 'name'
        value: param.get 'value'
    pairs

`export default ProxyEndpointTestSerializer`
