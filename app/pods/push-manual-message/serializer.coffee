`import ApplicationSerializer from 'gateway/serializers/application'`

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
      body = if body then JSON.parse body else null
    catch e
      serialized.dataError = true
      body = null
    serialized.payload = body
    delete serialized['body']
    serialized

`export default PushManualMessageSerializer`
