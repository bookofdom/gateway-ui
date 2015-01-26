`import DS from 'ember-data'`

Environment = DS.Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
  api: DS.belongsTo 'api', async: true

`export default Environment`
