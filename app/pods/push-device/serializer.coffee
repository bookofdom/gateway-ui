`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway/serializers/application'`

PushDeviceSerializer = ApplicationSerializer.extend
  attrs:
    push_channel:
      serialize: false
    push_messages:
      serialize: false

  modelNameFromPayloadKey: (payloadKey) ->
    'push-device'
  payloadKeyFromModelName: (modelName) ->
    'push_device'
  normalize: (type, hash, property) ->
    expires = new Date(hash.expires * 1000)
    hash.expires = expires.toISOString()
    # hash.links =
    #   push_messages: "/push_channels/#{hash.push_channel_id}/push_devices/#{hash.id}/push_messages"
    @_super arguments...
  serialize: (snapshot) ->
    serialized = @_super arguments...
    expires = new Date(snapshot.attributes().expires)
    serialized.expires = Math.floor(expires.getTime() / 1000)
    serialized

`export default PushDeviceSerializer`
