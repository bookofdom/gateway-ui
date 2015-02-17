`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

ProxyEndpointComponentTransformationSerializer = ApplicationSerializer.extend
  normalize: (type, hash, property) ->
    # `data` is reserved in Ember, so transform to `body` attribute
    hash.body = hash.data
    @_super.apply @, arguments
  serialize: (model) ->
    serialized = @_super.apply @, arguments
    # IDs should be numeric
    serialized.id = parseInt(serialized.id, 10) if serialized.id?
    # Serializes `body` back into `data`
    serialized.data = model.get 'body'
    delete serialized['body']
    serialized

`export default ProxyEndpointComponentTransformationSerializer`
