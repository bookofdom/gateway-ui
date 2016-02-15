`import DS from 'ember-data'`
`import ApplicationSerializer from './application'`

ProxyEndpointTestArgumentSerializer = ApplicationSerializer.extend
  attrs:
    proxy_endpoint_test:
      serialize: false

`export default ProxyEndpointTestArgumentSerializer`
