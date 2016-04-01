`import ApplicationSerializer from 'gateway/mirage/serializers/application'`

RemoteEndpointSerializer = ApplicationSerializer.extend
  serialize: (model) ->
    serialized = ApplicationSerializer.prototype.serialize.apply @, arguments
    environment_data = model.remote_endpoint_environment_data.map (ed) -> ed.attrs
    serialized.environment_data = environment_data if !serialized.environment_data
    serialized

`export default RemoteEndpointSerializer`
