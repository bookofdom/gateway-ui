`import ActionComponentSerializer from 'gateway/pods/action-component/serializer'`

ProxyEndpointComponentSerializer = ActionComponentSerializer.extend
  attrs:
    proxy_endpoint:
      serialize: false
    shared_component:
      serialize: 'id'
    calls:
      embedded: 'always'
    before:
      embedded: 'always'
    after:
      embedded: 'always'

`export default ProxyEndpointComponentSerializer`
