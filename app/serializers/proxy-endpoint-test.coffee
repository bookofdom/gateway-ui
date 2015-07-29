`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

ProxyEndpointTestSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    headers:
      embedded: 'always'
    query:
      embedded: 'always'
  normalize: (type, hash, property) ->
    @normalizeMethods hash
    @normalizeHeaders hash
    @normalizeQuery hash
    @_super.apply @, arguments
  normalizeMethods: (hash) ->
    hash.methods ?= []
    hash.method = hash.methods[0]
    hash
  normalizeHeaders: (hash) ->
    hash.pairs ?= []
    hash.headers = hash.pairs.filter (pair) -> pair.type is 'header'
    hash
  normalizeQuery: (hash) ->
    hash.pairs ?= []
    hash.query = hash.pairs.filter (pair) -> pair.type is 'get'
    hash
  serialize: (model) ->
    serialized = @_super.apply @, arguments
    serialized.id = parseInt(serialized.id, 10) if serialized.id?
    serialized.methods = if serialized.method then [serialized.method] else []
    serialized.pairs = @serializePairs model
    delete serialized['method']
    serialized
  serializePairs: (model) ->
    pairs = []
    model.get('headers').forEach (header) ->
      pairs.push
        id: header.get 'id'
        type: 'header'
        key: header.get 'key'
        value: header.get 'value'
    model.get('query').forEach (param) ->
      pairs.push
        id: param.get 'id'
        type: 'get'
        key: param.get 'key'
        value: param.get 'value'
    pairs

`export default ProxyEndpointTestSerializer`
