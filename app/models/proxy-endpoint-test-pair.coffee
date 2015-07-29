`import DS from 'ember-data'`
`import Model from './model'`

ProxyEndpointTestPair = Model.extend
  type: DS.attr 'string', defaultValue: 'get'
  key: DS.attr 'string', defaultValue: ''
  value: DS.attr 'string', defaultValue: ''
  proxy_endpoint_test: DS.belongsTo 'proxy-endpoint-test'

`export default ProxyEndpointTestPair`
