`import DS from 'ember-data'`
`import Model from './model'`

RemoteEndpointHeader = Model.extend
  name: DS.attr 'string'
  value: DS.attr 'string'

`export default RemoteEndpointHeader`
