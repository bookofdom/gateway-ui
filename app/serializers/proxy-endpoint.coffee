`import ApplicationSerializer from './application'`

ProxyEndpointSerializer = ApplicationSerializer.extend
  normalize: (type, hash, property) ->
    @_super.apply @, arguments

`export default ProxyEndpointSerializer`
