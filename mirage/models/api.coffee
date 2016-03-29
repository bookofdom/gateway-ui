`import { Model, hasMany } from 'ember-cli-mirage'`

ApiModel = Model.extend
  environments: hasMany()
  libraries: hasMany()
  hosts: hasMany()
  endpoint_groups: hasMany()

`export default ApiModel`
