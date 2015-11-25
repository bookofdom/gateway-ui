`import ProxyEndpointRelatedAdapter from './proxy-endpoint-related'`
`import config from  '../config/environment'`

ProxyEndpointSchemaAdapter = ProxyEndpointRelatedAdapter.extend
  pathForType: -> 'schemas'

`export default ProxyEndpointSchemaAdapter`
