`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`

EnvironmentVariable = Model.extend
  name: DS.attr 'string'
  value: DS.attr 'string'

  # Relationships
  environment: DS.belongsTo 'environment', async: false

`export default EnvironmentVariable`
