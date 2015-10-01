`import DS from 'ember-data'`
`import Model from './model'`

ProxyEndpointTestArgument = Model.extend
  name: DS.attr 'string'
  value: DS.attr 'string'

`export default ProxyEndpointTestArgument`
