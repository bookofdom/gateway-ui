`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Model from 'gateway/pods/model/model'`

JobTest = Model.extend
  name: DS.attr 'string'
  parameters: DS.attr 'string', defaultValue: '{}'

  # Relationships
  job: DS.belongsTo 'job', async: true

`export default JobTest`
