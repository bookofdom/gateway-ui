`import ApplicationSerializer from './application'`

ProxyEndpointSerializer = ApplicationSerializer.extend
  normalize: (type, hash, property) ->
    #console.log arguments
    @_super.apply @, arguments

`export default ProxyEndpointSerializer`
