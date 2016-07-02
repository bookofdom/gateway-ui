`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway/serializers/application'`

PushDeviceSerializer = ApplicationSerializer.extend
  normalize: (type, hash, property) ->
    expires = new Date(hash.expires * 1000)
    hash.expires = expires.toISOString()
    @_super arguments...
  serialize: (snapshot) ->
    serialized = @_super arguments...
    expires = new Date(snapshot.attributes().expires)
    serialized.expires = Math.floor(expires.getTime() / 1000)
    serialized

`export default PushDeviceSerializer`
