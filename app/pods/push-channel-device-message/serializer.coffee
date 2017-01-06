`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway-ui/pods/application/serializer'`

PushChannelDeviceMessageSerializer = ApplicationSerializer.extend
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

`export default PushChannelDeviceMessageSerializer`
