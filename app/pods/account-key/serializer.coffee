`import ApplicationSerializer from 'gateway/serializers/application'`

AccountKeySerializer = ApplicationSerializer.extend
  modelNameFromPayloadKey: (payloadKey) ->
    payloadKey.singularize().replace /^key$/, 'account-key'
  payloadKeyFromModelName: (modelName) ->
    modelName.replace /^account-key$/, 'key'

`export default AccountKeySerializer`
