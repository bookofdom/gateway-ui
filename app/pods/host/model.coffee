`import DS from 'ember-data'`
`import Model from 'gateway/pods/model/model'`

Host = Model.extend
  name: DS.attr 'string'
  hostname: DS.attr 'string'

  # Computed
  swaggerViewerUrl: Ember.computed 'hostname', ->
    adapter = Ember.getOwner(@).lookup 'adapter:host'
    adapter.buildSwaggerViewerUrl @

  # Relationships
  api: DS.belongsTo 'api', async: true

`export default Host`
