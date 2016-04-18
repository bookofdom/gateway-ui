PushRemoteEndpointSerializer =
  normalize: (hash) ->
    hash.publish_endpoint = hash.data.publish_endpoint

  serialize: (serialized) ->
    serialized.data = Ember.merge serialized.data,
      publish_endpoint: serialized.publish_endpoint

`export default PushRemoteEndpointSerializer`
