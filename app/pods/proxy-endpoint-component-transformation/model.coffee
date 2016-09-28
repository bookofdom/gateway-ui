`import DS from 'ember-data'`
`import ActionComponentTransformation from 'gateway/pods/action-component-transformation/model'`

ProxyEndpointComponentTransformation = ActionComponentTransformation.extend
  # Relationships
  proxy_endpoint_component: DS.belongsTo 'proxy-endpoint-component',
    inverse: null
    async: false
  proxy_endpoint_component_call: DS.belongsTo 'proxy-endpoint-component-call',
    inverse: null
    async: false

`export default ProxyEndpointComponentTransformation`
