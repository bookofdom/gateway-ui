`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

ProxyEndpointTestQueryParameterSerializer = ApplicationSerializer.extend
  attrs:
    proxy_endpoint_test:
      serialize: false

`export default ProxyEndpointTestQueryParameterSerializer`
