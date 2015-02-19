`import DS from 'ember-data'`
`import Model from './model'`

Host = Model.extend
  name: DS.attr 'string'
  api: DS.belongsTo 'api', async: true

`export default Host`
