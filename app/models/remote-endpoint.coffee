`import DS from 'ember-data'`

RemoteEndpoint = DS.Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
  type: DS.attr 'string', defaultValue: 'http'
  api: DS.belongsTo 'api', async: true
  environment_data: DS.hasMany 'remote-endpoint-environment-datum'

`export default RemoteEndpoint`
