`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`

CustomFunctionFile = Model.extend
  name: DS.attr 'string'
  body: DS.attr 'string'

  # Relationships
  custom_function: DS.belongsTo 'custom-function', async: true

`export default CustomFunctionFile`
