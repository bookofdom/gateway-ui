`import { Model, hasMany } from 'ember-cli-mirage'`

StoreCollectionModel = Model.extend
  store_objects: hasMany()

`export default StoreCollectionModel`
