`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

RemoteEndpointLikeSerializer = ApplicationSerializer.extend DS.EmbeddedRecordsMixin,
  attrs:
    headers:
      serialize: false
      deserialize: 'records'
    query:
      serialize: false
      deserialize: 'records'
    hosts:
      embedded: 'always'
    environment_data:
      embedded: 'always'

  normalize: (type, hash, property) ->
    hash.data ?= {}
    @normalizeHeaders hash
    @normalizeQuery hash
    @normalizeHosts hash
    @_super.apply @, arguments
  normalizeHeaders: (hash) ->
    hash.headers = []
    for key, value of (hash.data.headers || {})
      hash.headers.push
        name: key
        value: value
    hash
  normalizeQuery: (hash) ->
    hash.query = []
    for key, value of (hash.data.query or {})
      hash.query.push
        name: key
        value: value
    hash
  normalizeHosts: (hash) ->
    hash.hosts = hash.data.config.hosts if hash.data?.config?.hosts

`export default RemoteEndpointLikeSerializer`
