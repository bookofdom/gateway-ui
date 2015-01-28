`import DS from 'ember-data'`

ProxyEndpoint = DS.Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
  active: DS.attr 'boolean'
  api: DS.belongsTo 'api', async: true
  environment: DS.belongsTo 'environment', async: true
  endpoint_group: DS.belongsTo 'endpoint-group', async: true

`export default ProxyEndpoint`
