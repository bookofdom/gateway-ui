`import DS from 'ember-data'`

ProxyEndpointComponentCall = DS.Model.extend
  endpoint_name_override: DS.attr 'string'
  conditional: DS.attr 'string'
  conditional_positive: DS.attr 'boolean', defaultValue: true
  remote_endpoint: DS.belongsTo 'remote-endpoint', async: true
  proxy_endpoint_component: DS.belongsTo 'proxy-endpoint-component'

`export default ProxyEndpointComponentCall`
