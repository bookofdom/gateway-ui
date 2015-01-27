`import DS from 'ember-data'`

Api = DS.Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
  cors_allow: DS.attr 'string', defaultValue: '*'
  environments: DS.hasMany 'environment', async: true
  endpoint_groups: DS.hasMany 'endpoint-group', async: true

`export default Api`
