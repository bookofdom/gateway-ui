`import { Model, belongsTo } from 'ember-cli-mirage'`

CustomFunctionTestModel = Model.extend
  custom_function: belongsTo()

`export default CustomFunctionTestModel`
