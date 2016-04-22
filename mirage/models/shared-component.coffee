`import { Model, belongsTo } from 'ember-cli-mirage'`

SharedComponentModel = Model.extend
  api: belongsTo()

`export default SharedComponentModel`
