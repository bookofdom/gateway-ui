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
    serialized.component_id = parseInt(serialized.component_id, 10) if serialized.component_id?
    serialized.call_id = parseInt(serialized.call_id, 10) if serialized.call_id?
    # Serializes `body` back into `data`
    serialized.data = model.get 'body'
    delete serialized['body']
    serialized

`export default ProxyEndpointComponentTransformationSerializer`
