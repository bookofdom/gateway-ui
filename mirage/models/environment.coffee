`import { Model, belongsTo } from 'ember-cli-mirage'`

EnvironmentModel = Model.extend
  api: belongsTo()

`export default EnvironmentModel`
