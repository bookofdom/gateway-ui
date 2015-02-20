`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

RemoteEndpointSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    environment_data:
      embedded: 'always'
  normalize: (type, hash, property) ->
    # `data` is reserved in Ember, so transform into `url` and `method`
    hash.url = hash.data.url
    hash.method = hash.data.method
    @normalizeEnvironmentData hash
    @normalizeEnvironmentDataLinks hash
    @_super.apply @, arguments
  # Adds ephemeral IDs to embedded environment data records, since IDs are required.
  normalizeEnvironmentData: (hash) ->
    datumIdCounter = parseInt(hash.id, 10) * 10000
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
  serialize: (model) ->
    serialized = @_super.apply @, arguments
    serialized.data =
      url: model.get 'url'
      method: model.get 'method'
    serialized

`export default RemoteEndpointSerializer`
