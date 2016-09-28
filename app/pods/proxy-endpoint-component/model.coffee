`import DS from 'ember-data'`
`import ActionComponent from 'gateway/pods/action-component/model'`

ProxyEndpointComponent = ActionComponent.extend
  # Relationships
  proxy_endpoint: DS.belongsTo 'proxy-endpoint', async: false
  calls: DS.hasMany 'proxy-endpoint-component-call',
    async: false
    stains: true
    embeddedModel: true
  before: DS.hasMany 'proxy-endpoint-component-transformation',
    async: false
    stains: true
    embeddedModel: true
  after: DS.hasMany 'proxy-endpoint-component-transformation',
    async: false
    stains: true
    embeddedModel: true

`export default ProxyEndpointComponent`
