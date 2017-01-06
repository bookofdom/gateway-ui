`import DS from 'ember-data'`
`import Model from 'gateway-ui/pods/model/model'`

StoreObject = Model.extend
  body: DS.attr 'string', defaultValue: '{}'

  # Relationships
  store_collection: DS.belongsTo 'store-collection', async: true

  # Computed
  json: Ember.computed 'body', ->
    try
      json = JSON.parse @get 'body'
    json
  jsonKeys: Ember.computed 'json', ->
    json = @get 'json'
    if json
      Object.keys json
    else
      []

`export default StoreObject`
