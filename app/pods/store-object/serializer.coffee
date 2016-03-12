`import ApplicationSerializer from 'gateway/serializers/application'`

StoreObjectSerializer = ApplicationSerializer.extend
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

`export default StoreObjectSerializer`
