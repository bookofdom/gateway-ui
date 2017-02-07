`import ApplicationSerializer from 'gateway-ui/mirage/serializers/application'`

CustomFunctionTestSerializer = ApplicationSerializer.extend
  keyForModel: -> 'test'

`export default CustomFunctionTestSerializer`
