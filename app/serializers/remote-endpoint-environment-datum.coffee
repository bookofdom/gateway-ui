`import DS from 'ember-data'`
`import RemoteEndpointLikeSerializer from './remote-endpoint-like'`

RemoteEndpointEnvironmentDatumSerializer = RemoteEndpointLikeSerializer.extend
  normalize: (type, hash, property) ->
    # `data` is reserved in Ember, so transform into `url` and `method`
    hash.url = hash.data.url
    hash.method = hash.data.method
    @_super.apply @, arguments
  serialize: (model) ->
    serialized = @_super.apply @, arguments
    serialized.data = Ember.merge serialized.data,
      url: model.get 'url'
      method: model.get 'method'
    serialized

`export default RemoteEndpointEnvironmentDatumSerializer`
