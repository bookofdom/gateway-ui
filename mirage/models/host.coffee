`import { Model, belongsTo } from 'ember-cli-mirage'`

HostModel = Model.extend
  api: belongsTo()

`export default HostModel`
