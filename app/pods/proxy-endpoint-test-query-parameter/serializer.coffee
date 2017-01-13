`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway-ui/pods/application/serializer'`

ProxyEndpointTestQueryParameterSerializer = ApplicationSerializer.extend
  attrs:
    proxy_endpoint_test:
      serialize: false

`export default ProxyEndpointTestQueryParameterSerializer`
