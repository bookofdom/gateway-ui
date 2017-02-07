`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway-ui/pods/application/serializer'`

CustomFunctionTestSerializer = ApplicationSerializer.extend
  attrs:
    custom_function:
      serialize: false

  modelNameFromPayloadKey: (payloadKey) ->
    'custom-function-test'
  payloadKeyFromModelName: (modelName) ->
    'test'

  normalize: (type, hash, property) ->
    try
      hash.input = vkbeautify.json JSON.stringify(hash.input)
    @_super arguments...

  serialize: (snapshot) ->
    serialized = @_super arguments...

    input = snapshot.attributes().input
    try
      json = JSON.parse input if input
    serialized.input = json
    serialized

`export default CustomFunctionTestSerializer`
