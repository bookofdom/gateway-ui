`import ApplicationSerializer from 'gateway-ui/pods/application/serializer'`

ProxyEndpointChannelSerializer = ApplicationSerializer.extend
  attrs:
    proxy_endpoint:
      serialize: false

  modelNameFromPayloadKey: (payloadKey) ->
    'proxy-endpoint-channel'
  payloadKeyFromModelName: (modelName) ->
    'channel'

`export default ProxyEndpointChannelSerializer`
