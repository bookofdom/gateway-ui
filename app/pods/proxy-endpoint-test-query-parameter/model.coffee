`import DS from 'ember-data'`
`import Model from 'gateway/pods/model/model'`

ProxyEndpointTestQueryParameter = Model.extend
  name: DS.attr 'string'
  value: DS.attr 'string'

  # Relationships
  proxy_endpoint_test: DS.belongsTo 'proxy-endpoint-test', async: false

`export default ProxyEndpointTestQueryParameter`
