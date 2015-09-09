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
    # normalize embedded resources
    hash.headers = @objectToArray hash.data.headers
    hash.query = @objectToArray hash.data.query
    hash.hosts = hash.data.config.hosts if hash.data?.config?.hosts
    @_super.apply @, arguments

  objectToArray: (obj={}) ->
    for key, value of obj
      name: key
      value: value

`export default RemoteEndpointLikeSerializer`
