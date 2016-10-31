`import ApplicationSerializer from 'gateway/pods/application/serializer'`

PushManualMessageSerializer = ApplicationSerializer.extend
  attrs:
    push_channel:
      serialize: false

  modelNameFromPayloadKey: (payloadKey) ->
    'push-manual-message'
  payloadKeyFromModelName: (modelName) ->
    'push_manual_message'
  serialize: (snapshot) ->
    serialized = @_super arguments...
    body = snapshot.attributes().body
    try
      payload = if body then JSON.parse body else null
    serialized.payload = payload
    delete serialized['body']
    serialized

`export default PushManualMessageSerializer`
