`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

ProxyEndpointTestSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    pairs:
      embedded: 'always'
  normalize: (type, hash, property) ->
    @normalizeMethods hash
    @normalizeContentType hash
    @_super.apply @, arguments
  normalizeMethods: (hash) ->
    hash.methods ?= []
    hash.methods = (method.toLowerCase() for method in hash.methods)
    hash.method = hash.methods[0] if hash.methods.length > 0
    delete hash['methods']
    hash
  normalizeContentType: (hash) ->
    hash.pairs ?= []
    for pair in hash['pairs']
      if pair['type'] == 'header' && pair['key'] == 'Content-Type'
        hash.content_type = pair['value']
    hash
  serialize: (model) ->
    serialized = @_super.apply @, arguments
    serialized.id = parseInt(serialized.id, 10) if serialized.id?
    serialized.methods = model.get 'methodsArray'
    delete serialized['methodsArray']
    delete serialized['method']
    delete serialized['content_type']
    serialized

`export default ProxyEndpointTestSerializer`
