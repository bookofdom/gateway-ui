`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway/serializers/application'`

PushChannelSerializer = ApplicationSerializer.extend
  attrs:
    push_devices:
      serialize: false
  keep_api_id: true

  normalize: (type, hash, property) ->
    expires = new Date(hash.expires * 1000)
    hash.expires = expires.toISOString()
    hash.links =
      push_devices: 'push_devices'
    @_super arguments...
  serialize: (snapshot) ->
    serialized = @_super arguments...
    expires = new Date(snapshot.attributes().expires)
    serialized.expires = Math.floor(expires.getTime() / 1000)
    serialized

`export default PushChannelSerializer`
