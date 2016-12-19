`import ApplicationSerializer from 'gateway/mirage/serializers/application'`

ProxyEndpointChannelSerializer = ApplicationSerializer.extend
  keyForModel: -> 'channel'

`export default ProxyEndpointChannelSerializer`
