`import DS from 'ember-data'`

EndpointGroup = DS.Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
  api: DS.belongsTo 'api', async: true

`export default EndpointGroup`
