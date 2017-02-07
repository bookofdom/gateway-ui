`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`

CustomFunctionTest = Model.extend
  name: DS.attr 'string'
  input: DS.attr 'string', defaultValue: '{}'

  # Relationships
  custom_function: DS.belongsTo 'custom-function', async: true

  executeTest: ->
    adapter = Ember.getOwner(@).lookup 'adapter:custom-function-test'
    adapter.executeTest @

`export default CustomFunctionTest`
