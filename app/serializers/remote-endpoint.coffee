`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

datumIdCounter = 1

RemoteEndpointSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    environment_data:
      embedded: 'always'
  normalize: (type, hash, property) ->
    @normalizeEnvironmentData hash
    @_super.apply @, arguments
  # Adds ephemeral IDs to embedded environment data records, since IDs are required.
  normalizeEnvironmentData: (hash) ->
    hash.environment_data ?= []
    for datum in hash.environment_data
      datum.id = datumIdCounter++
    hash

`export default RemoteEndpointSerializer`
