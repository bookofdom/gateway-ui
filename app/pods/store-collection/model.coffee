`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`

StoreCollection = Model.extend
  name: DS.attr 'string'

  # Relationships
  store_objects: DS.hasMany 'store-object', async: true

`export default StoreCollection`
