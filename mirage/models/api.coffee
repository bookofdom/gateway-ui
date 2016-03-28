`import { Model, hasMany } from 'ember-cli-mirage'`

ApiModel = Model.extend
  libraries: hasMany()
  hosts: hasMany()
  endpoint_groups: hasMany()

`export default ApiModel`
