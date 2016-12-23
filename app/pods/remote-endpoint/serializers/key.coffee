KeyEndpointSerializer =
  normalize: (hash) ->
    hash.name = hash.data.config.name

  serialize: (serialized) ->
    serialized.data = Ember.merge serialized.data,
      config:
        name: serialized.name

`export default KeyEndpointSerializer`
