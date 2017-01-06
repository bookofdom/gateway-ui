`import ApplicationSerializer from 'gateway-ui/pods/application/serializer'`

StoreObjectSerializer = ApplicationSerializer.extend
  normalize: (type, hash, property) ->
    # `data` is reserved in Ember, so transform to `body` attribute
    try
      hash.body = vkbeautify.json JSON.stringify(hash.data)
    @_super arguments...

  serialize: (snapshot) ->
    serialized = @_super arguments...
    # Serializes `body` back into `data`
    # If a JSON parse error occurs, passes a boolean to the adapter so that
    # the adapter can raise an invalid error.
    body = snapshot.attributes().body
    try
      json = JSON.parse body if body
    serialized.data = json
    delete serialized['body']
    serialized

`export default StoreObjectSerializer`
