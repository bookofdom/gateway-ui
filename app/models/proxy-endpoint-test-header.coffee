`import DS from 'ember-data'`
`import Model from './model'`

ProxyEndpointTestHeader = Model.extend
  name: DS.attr 'string'
  value: DS.attr 'string'

`export default ProxyEndpointTestHeader`
