`import ApplicationSerializer from 'gateway/pods/application/serializer'`

ProxyEndpointChannelSerializer = ApplicationSerializer.extend
  attrs:
    proxy_endpoint:
      serialize: false

`export default ProxyEndpointChannelSerializer`
