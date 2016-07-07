`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway/serializers/application'`

PushChannelDeviceMessageSerializer = ApplicationSerializer.extend
  attrs:
    push_device:
      serialize: false

  modelNameFromPayloadKey: (payloadKey) ->
    'push-channel-device-message'
  payloadKeyFromModelName: (modelName) ->
    'push_message'
  normalize: (type, hash, property) ->
    stamp = new Date(hash.stamp * 1000)
    hash.stamp = stamp.toISOString()
    try
      hash.body = vkbeautify.json JSON.stringify(hash.data)
    @_super arguments...
  serialize: (snapshot) ->
    serialized = @_super arguments...
    stamp = new Date(snapshot.attributes().stamp)
    serialized.stamp = Math.floor(stamp.getTime() / 1000)
    body = snapshot.attributes().body
    try
      body = JSON.parse body if body
    catch e
      serialized.dataError = true
    serialized.data = body
    delete serialized['body']
    serialized

`export default PushChannelDeviceMessageSerializer`
