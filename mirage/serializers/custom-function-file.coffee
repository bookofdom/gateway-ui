`import ApplicationSerializer from 'gateway-ui/mirage/serializers/application'`

CustomFunctionFileSerializer = ApplicationSerializer.extend
  keyForModel: -> 'file'

`export default CustomFunctionFileSerializer`
