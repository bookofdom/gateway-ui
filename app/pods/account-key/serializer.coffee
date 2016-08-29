`import ApplicationSerializer from 'gateway/serializers/application'`

AccountKeySerializer = ApplicationSerializer.extend
  modelNameFromPayloadKey: (payloadKey) ->
    payloadKey.replace /^keys$/, 'account-key'

`export default AccountKeySerializer`
