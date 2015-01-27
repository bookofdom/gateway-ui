`import DS from 'ember-data'`

RemoteEndpoint = DS.Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
  type: DS.attr 'string'
  api: DS.belongsTo 'api', async: true

`export default RemoteEndpoint`
