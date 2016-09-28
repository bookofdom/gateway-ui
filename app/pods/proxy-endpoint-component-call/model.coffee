`import DS from 'ember-data'`
`import ActionComponentCall from 'gateway/pods/action-component-call/model'`

ProxyEndpointComponentCall = ActionComponentCall.extend
  # Relationships
  before: DS.hasMany 'proxy-endpoint-component-transformation', async: false
  after: DS.hasMany 'proxy-endpoint-component-transformation', async: false
  proxy_endpoint_component: DS.belongsTo 'proxy-endpoint-component',
    async: false

`export default ProxyEndpointComponentCall`
