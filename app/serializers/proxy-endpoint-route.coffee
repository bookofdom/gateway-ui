`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

ProxyEndpointRouteSerializer = ApplicationSerializer.extend
  attrs:
    proxy_endpoint:
      serialize: false
  normalize: (type, hash, property) ->
    @normalizeMethods hash
    @_super.apply @, arguments
  normalizeMethods: (hash) ->
    hash.methods ?= []
    hash.methods = (method.toLowerCase() for method in hash.methods)
    hash.get_method = hash.methods.contains 'get'
    hash.post_method = hash.methods.contains 'post'
    hash.put_method = hash.methods.contains 'put'
    hash.delete_method = hash.methods.contains 'delete'
    delete hash['method']
    hash
  serialize: (snapshot) ->
    serialized = @_super.apply @, arguments
    serialized.methods = snapshot.attributes().methodsArray
    delete serialized['methodsArray']
    serialized

`export default ProxyEndpointRouteSerializer`
