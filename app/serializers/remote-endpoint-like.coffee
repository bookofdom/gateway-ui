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
  # embedded records that have no IDs.  Optionally accepts `startsAt`, to offset
  # generated IDs by a given number.
  generateChildIdFor: (modelName, ownerId, offset=0) ->
    idCounter = idCounters[modelName] or 0
    startsAt = @get "idStartingAt.#{modelName}"
    idCounter++
    idCounters[modelName] = idCounter
    idCounter = idCounter + offset
    idCounter

`export default RemoteEndpointLikeSerializer`
