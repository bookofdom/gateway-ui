`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

datumIdCounter = 1

RemoteEndpointSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    environment_data:
      embedded: 'always'
  normalize: (type, hash, property) ->
    @normalizeEnvironmentData hash
    @normalizeEnvironmentDataLinks hash
    @_super.apply @, arguments
  # Adds ephemeral IDs to embedded environment data records, since IDs are required.
  normalizeEnvironmentData: (hash) ->
    hash.environment_data ?= []
    for datum in hash.environment_data
      datum.id = datumIdCounter++
    hash
  # Adds links to embedded environment data
  normalizeEnvironmentDataLinks: (hash) ->
    if hash.environment_data
      for datum in hash.environment_data
        if datum.environment_id
          datum.links =
            environment: "/apis/#{hash.api_id}/environments/#{datum.environment_id}"
    hash

`export default RemoteEndpointSerializer`
