`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`
`import ProxyEndpointTest from '../models/proxy-endpoint-test'`

ProxyEndpointTestSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    headers:
      embedded: 'always'
    query:
      embedded: 'always'
    arguments:
      embedded: 'always'
  normalize: (type, hash, property) ->
    @normalizeMethods hash
    @normalizeHeaders hash
    @normalizeQuery hash
    @normalizeArguments hash
    delete hash.pairs
    @_super.apply @, arguments
  normalizeMethods: (hash) ->
    hash.methods ?= []
    hash.method = hash.methods[0]
    delete hash.methods
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
  normalizeArguments: (hash) ->
    hash.pairs ?= []
    hash.arguments = hash.pairs.filter (pair) -> pair.type is 'path'
    hash.arguments = hash.arguments.map (param) ->
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
    delete serialized.arguments
    serialized
  serializePairs: (model, serialized) ->
    pairs = []
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
    model.get('arguments').forEach (param) ->
      id = param.get 'id'
      id = parseInt(id, 10) if id
      pairs.push
        id: id
        type: 'path'
        key: param.get 'name'
        value: param.get 'value'
    pairs

`export default ProxyEndpointTestSerializer`
