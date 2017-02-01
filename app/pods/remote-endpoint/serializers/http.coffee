HttpRemoteEndpointSerializer =
  normalize: (hash) ->
    # `data` is reserved in Ember, so transform into `url` and `method`
    hash.url = hash.data.url
    hash.method = hash.data.method
    hash.skip_ssl_verification = hash.data.skip_ssl_verification

  serialize: (serialized) ->
    serialized.data = Ember.merge serialized.data,
      url: serialized.url
      method: serialized.method
      skip_ssl_verification: serialized.skip_ssl_verification

`export default HttpRemoteEndpointSerializer`
