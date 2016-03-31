`import { Model, belongsTo, hasMany } from 'ember-cli-mirage'`

SharedComponentModel = Model.extend
  api: belongsTo()

`export default SharedComponentModel`
