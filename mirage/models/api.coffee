`import { Model, hasMany } from 'ember-cli-mirage'`

ApiModel = Model.extend
  libraries: hasMany()
  hosts: hasMany()

`export default ApiModel`
