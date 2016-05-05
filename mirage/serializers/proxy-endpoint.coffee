`import ApplicationSerializer from 'gateway/mirage/serializers/application'`

ProxyEndpointSerializer = ApplicationSerializer.extend
  serialize: (model) ->
    serialized = ApplicationSerializer.prototype.serialize.apply @, arguments
    components = model.proxy_endpoint_components.map (ed) ->
      ed.attrs.proxy_endpoint_component_reference_id = ed.attrs.id
      ed.attrs
    serialized.components = components if !serialized.components
    serialized

`export default ProxyEndpointSerializer`
