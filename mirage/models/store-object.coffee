`import { Model, belongsTo } from 'ember-cli-mirage'`

StoreObjectModel = Model.extend
  store_collection: belongsTo()

`export default StoreObjectModel`
