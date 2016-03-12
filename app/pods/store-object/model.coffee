`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`

StoreObject = Model.extend
  body: DS.attr 'string'

  # Relationships
  store_collection: DS.belongsTo 'store-collection', async: true

`export default StoreObject`
