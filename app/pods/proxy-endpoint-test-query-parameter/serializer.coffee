`import DS from 'ember-data'`
`import ApplicationSerializer from 'gateway/serializers/application'`

ProxyEndpointTestQueryParameterSerializer = ApplicationSerializer.extend
  attrs:
    proxy_endpoint_test:
      serialize: false

`export default ProxyEndpointTestQueryParameterSerializer`
