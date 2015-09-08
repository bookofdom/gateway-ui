`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

# ID counters are be stored outside the serializer instance to ensure that
# generated IDs are globally unique.
idCounters = {}

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
  # Returns a generated consecutive ID for an embedded model.  Useful for
  # embedded records that have no IDs.
  generateChildIdFor: (modelName, ownerId) ->
    idCounter = idCounters[modelName] || 0
    idCounter++
    idCounters[modelName] = idCounter
    idCounter

`export default RemoteEndpointLikeSerializer`
