`import DS from 'ember-data'`
`import Model from './model'`

RemoteEndpointHeader = Model.extend
  name: DS.attr 'string'
  value: DS.attr 'string'
  environment_datum: DS.belongsTo 'remote-endpoint-environment-datum'

`export default RemoteEndpointHeader`
