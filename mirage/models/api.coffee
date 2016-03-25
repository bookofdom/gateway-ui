`import { Model, hasMany } from 'ember-cli-mirage'`

ApiModel = Model.extend
  libraries: hasMany()

`export default ApiModel`
