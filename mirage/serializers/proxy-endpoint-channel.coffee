`import ApplicationSerializer from 'gateway-ui/mirage/serializers/application'`

ProxyEndpointChannelSerializer = ApplicationSerializer.extend
  keyForModel: -> 'channel'

`export default ProxyEndpointChannelSerializer`
