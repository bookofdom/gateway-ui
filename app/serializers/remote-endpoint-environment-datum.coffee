`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

RemoteEndpointEnvironmentDatumSerializer = ApplicationSerializer.extend
  normalize: (type, hash, property) ->
    # `data` is reserved in Ember, so transform into `url` attribute
    hash.url = hash.data.url
    @_super.apply @, arguments
  serialize: (model) ->
    serialized = @_super.apply @, arguments
    serialized.data =
      url: model.get 'url'
    serialized

`export default RemoteEndpointEnvironmentDatumSerializer`
