`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`

ProxyEndpointTestHeader = Model.extend
  name: DS.attr 'string'
  value: DS.attr 'string'

  # Relationships
  proxy_endpoint_test: DS.belongsTo 'proxy-endpoint-test', async: false

`export default ProxyEndpointTestHeader`
