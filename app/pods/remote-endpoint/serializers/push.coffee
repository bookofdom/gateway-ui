PushRemoteEndpointSerializer =
  normalize: (hash) ->
    hash.publish_endpoint = hash.data.publish_endpoint
    hash.subscribe_endpoint = hash.data.subscribe_endpoint
    hash.unsubscribe_endpoint = hash.data.unsubscribe_endpoint

  serialize: (serialized) ->
    serialized.data = Ember.merge serialized.data,
      publish_endpoint: serialized.publish_endpoint
      subscribe_endpoint: serialized.subscribe_endpoint
      unsubscribe_endpoint: serialized.unsubscribe_endpoint
      push_platforms: serialized.push_platforms
    delete serialized.push_platforms

`export default PushRemoteEndpointSerializer`
