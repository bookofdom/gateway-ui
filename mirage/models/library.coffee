`import { Model, belongsTo } from 'ember-cli-mirage'`

LibraryModel = Model.extend
  api: belongsTo()

`export default LibraryModel`
