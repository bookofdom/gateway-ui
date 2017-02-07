`import { Model, belongsTo, hasMany } from 'ember-cli-mirage'`

CustomFunctionModel = Model.extend
  api: belongsTo()
  custom_function_files: hasMany()
  custom_function_tests: hasMany()

`export default CustomFunctionModel`
