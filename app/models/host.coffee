`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`

Host = Model.extend
  name: DS.attr 'string'
  hostname: DS.attr 'string'

  # Computed
  swaggerViewerUrl: Ember.computed 'hostname', ->
    adapter = @container.lookup 'adapter:host'
    adapter.buildSwaggerViewerUrl @

  # Relationships
  api: DS.belongsTo 'api', async: true

`export default Host`
