`import { Model, hasMany } from 'ember-cli-mirage'`

ApiModel = Model.extend
  environments: hasMany()
  libraries: hasMany()
  hosts: hasMany()
  endpoint_groups: hasMany()
  remote_endpoints: hasMany()
  shared_components: hasMany()
  proxy_endpoints: hasMany()
  jobs: hasMany()

`export default ApiModel`
