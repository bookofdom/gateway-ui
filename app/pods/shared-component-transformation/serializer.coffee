`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway/serializers/application'`

SharedComponentTransformationSerializer = ApplicationSerializer.extend
  attrs:
    shared_component:
      serialize: false
    shared_component_call:
      serialize: false
  normalize: (type, hash, property) ->
    # `data` is reserved in Ember, so transform to `body` attribute
    hash.body = hash.data
    @_super.apply @, arguments
  serialize: (snapshot) ->
    serialized = @_super.apply @, arguments
    # Serializes `body` back into `data`
    serialized.data = snapshot.attributes().body
    delete serialized['body']
    serialized

`export default SharedComponentTransformationSerializer`
