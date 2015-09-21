`import DS from 'ember-data'`
`import Model from './model'`

Host = Model.extend
  name: DS.attr 'string'
  hostname: DS.attr 'string'

  # Relationships
  api: DS.belongsTo 'api', async: true

`export default Host`
