`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

ProxyEndpointTestSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    pairs:
      embedded: 'always'
  normalize: (type, hash, property) ->
    @normalizeMethods hash
    @_super.apply @, arguments
  normalizeMethods: (hash) ->
    hash.methods ?= []
    hash.methods = (method.toLowerCase() for method in hash.methods)
    hash.method = hash.methods[0] if hash.methods.length > 0
    delete hash['methods']
    hash
  serialize: (model) ->
    serialized = @_super.apply @, arguments
    serialized.id = parseInt(serialized.id, 10) if serialized.id?
    serialized.methods = if serialized.method then [serialized.method] else []
    delete serialized['method']
    serialized

`export default ProxyEndpointTestSerializer`
