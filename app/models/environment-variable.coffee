`import DS from 'ember-data'`
`import Model from './model'`

EnvironmentVariable = Model.extend
  name: DS.attr 'string'
  value: DS.attr 'string'

  # Relationships
  environment: DS.belongsTo 'environment', async: false

`export default EnvironmentVariable`
