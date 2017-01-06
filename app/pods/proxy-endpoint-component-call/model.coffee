`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`

ProxyEndpointComponentCall = Model.extend
  endpoint_name_override: DS.attr 'string'
  conditional: DS.attr 'string', defaultValue: ''
  conditional_positive: DS.attr 'boolean', defaultValue: true

  # Relationships
  remote_endpoint: DS.belongsTo 'remote-endpoint',
    async: false
    stains: true
  before: DS.hasMany 'proxy-endpoint-component-transformation', async: false
  after: DS.hasMany 'proxy-endpoint-component-transformation', async: false
  proxy_endpoint_component: DS.belongsTo 'proxy-endpoint-component',
    async: false

`export default ProxyEndpointComponentCall`
