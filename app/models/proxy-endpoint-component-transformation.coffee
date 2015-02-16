`import DS from 'ember-data'`
`import Model from './model'`

ProxyEndpointComponentTransformation = Model.extend
  type: DS.attr 'string', defaultValue: 'js'
  body: DS.attr 'string'
  proxy_endpoint_component: DS.belongsTo 'proxy-endpoint-component', inverse: null

`export default ProxyEndpointComponentTransformation`
