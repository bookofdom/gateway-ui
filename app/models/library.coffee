`import DS from 'ember-data'`
`import Model from './model'`

Library = Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
  body: DS.attr 'string', defaultValue: ''
  internal: DS.attr 'boolean'

  # Computed
  value: Ember.computed 'body', ->
    @get 'body'

  # Relationships
  api: DS.belongsTo 'api', async: true

`export default Library`
