`import ApplicationSerializer from 'gateway/mirage/serializers/application'`

StatSerializer = ApplicationSerializer.extend
  serialize: (model) ->
    serialized = ApplicationSerializer.prototype.serialize.apply @, arguments
    serialized.timestamp = model.time
    serialized

`export default StatSerializer`
