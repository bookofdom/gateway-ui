`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

ProxyEndpointRouteSerializer = ApplicationSerializer.extend
  attrs:
    proxy_endpoint:
      serialize: false
  normalize: (type, hash, property) ->
    @normalizeMethods hash
    @_super arguments...
  normalizeMethods: (hash) ->
    hash.methods ?= []
    hash.methods = (method.toLowerCase() for method in hash.methods)
    hash.get_method = hash.methods.contains 'get'
    hash.post_method = hash.methods.contains 'post'
    hash.put_method = hash.methods.contains 'put'
    hash.delete_method = hash.methods.contains 'delete'
    delete hash['methods']
    hash
  serialize: (snapshot) ->
    serialized = @_super arguments...
    serialized.methods = @serializeMethods serialized
    serialized
  serializeMethods: (serialized) ->
    methods = for method in ['get', 'post', 'put', 'delete']
      method.toUpperCase() if serialized["#{method}_method"]
    methods.compact()

`export default ProxyEndpointRouteSerializer`
