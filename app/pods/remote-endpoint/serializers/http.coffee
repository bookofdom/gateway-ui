HttpRemoteEndpointSerializer =
  normalize: (hash) ->
    # `data` is reserved in Ember, so transform into `url` and `method`
    hash.url = hash.data.url
    hash.method = hash.data.method

  serialize: (serialized) ->
    serialized.data = Ember.merge serialized.data,
      url: serialized.url
      method: serialized.method

`export default HttpRemoteEndpointSerializer`
