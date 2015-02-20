`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

RemoteEndpointEnvironmentDatumSerializer = ApplicationSerializer.extend
  normalize: (type, hash, property) ->
    # `data` is reserved in Ember, so transform into `url` and `method`
    hash.url = hash.data.url
    hash.method = hash.data.method
    @_super.apply @, arguments
  serialize: (model) ->
    serialized = @_super.apply @, arguments
    serialized.data =
      url: model.get 'url'
      method: model.get 'method'
    serialized

`export default RemoteEndpointEnvironmentDatumSerializer`
