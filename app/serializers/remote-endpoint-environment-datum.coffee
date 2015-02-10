`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

RemoteEndpointEnvironmentDatumSerializer = ApplicationSerializer.extend
  normalize: (type, hash, property) ->
    # `data` is reserved in Ember, so transform into `url` attribute
    hash.url = hash.data.url
    @_super.apply @, arguments

`export default RemoteEndpointEnvironmentDatumSerializer`
