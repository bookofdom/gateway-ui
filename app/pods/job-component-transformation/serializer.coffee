`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway/pods/application/serializer'`

JobComponentTransformationSerializer = ApplicationSerializer.extend
  attrs:
    proxy_endpoint_component:
      serialize: false
    proxy_endpoint_component_call:
      serialize: false
  normalize: (type, hash, property) ->
    # `data` is reserved in Ember, so transform to `body` attribute
    hash.body = hash.data
    @_super arguments...
  serialize: (snapshot) ->
    serialized = @_super arguments...
    # Serializes `body` back into `data`
    serialized.data = snapshot.attributes().body
    delete serialized['body']
    serialized

`export default JobComponentTransformationSerializer`
