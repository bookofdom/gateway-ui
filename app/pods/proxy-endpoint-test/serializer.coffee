`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway-ui/pods/application/serializer'`
`import ProxyEndpointTest from 'gateway-ui/pods/proxy-endpoint-test/model'`

ProxyEndpointTestSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    proxy_endpoint:
      serialize: false
    headers:
      embedded: 'always'
    query:
      embedded: 'always'
    arguments:
      embedded: 'always'
  normalize: (type, hash, property) ->
    hash.headers = [] if !hash.headers
    hash.query = [] if !hash.query
    hash.arguments = [] if !hash.arguments
    @normalizeMethods hash
    @normalizeHeaders hash
    @normalizeQuery hash
    @normalizeArguments hash
    delete hash.pairs
    @_super arguments...
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
  serialize: (snapshot) ->
    serialized = @_super arguments...
    serialized.methods = if serialized.method then [serialized.method] else []
    serialized.pairs = @serializePairs snapshot, serialized
    delete serialized.method
    delete serialized.headers
    delete serialized.query
    delete serialized.arguments
    serialized
  serializePairs: (snapshot, serialized) ->
    pairs = []
    snapshot.hasMany('headers').forEach (headerSnapshot) ->
      header = headerSnapshot.attributes()
      id = header.id
      id = parseInt(id, 10) if id
      pairs.push
        id: id
        type: 'header'
        key: header.name
        value: header.value
    snapshot.hasMany('query').forEach (querySnapshot) ->
      param = querySnapshot.attributes()
      id = param.id
      id = parseInt(id, 10) if id
      pairs.push
        id: id
        type: 'get'
        key: param.name
        value: param.value
    snapshot.hasMany('arguments').forEach (argumentsSnapshot) ->
      param = argumentsSnapshot.attributes()
      id = param.id
      id = parseInt(id, 10) if id
      pairs.push
        id: id
        type: 'path'
        key: param.name
        value: param.value
    pairs

`export default ProxyEndpointTestSerializer`
