`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

ProxyEndpointComponentTransformationSerializer = ApplicationSerializer.extend
  normalize: (type, hash, property) ->
    # `data` is reserved in Ember, so transform to `body` attribute
    hash.body = hash.data
    @_super.apply @, arguments

`export default ProxyEndpointComponentTransformationSerializer`
