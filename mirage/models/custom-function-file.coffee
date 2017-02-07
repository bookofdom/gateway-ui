`import { Model, belongsTo } from 'ember-cli-mirage'`

CustomFunctionFileModel = Model.extend
  custom_function: belongsTo()

`export default CustomFunctionFileModel`
