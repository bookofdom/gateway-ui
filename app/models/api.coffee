`import DS from 'ember-data'`
`import Model from './model'`

Api = Model.extend
  name: DS.attr 'string'
  description: DS.attr 'string'
  cors_allow_origin: DS.attr 'string'
  cors_allow_headers: DS.attr 'string', defaultValue: 'content-type, accept'
  cors_allow_credentials: DS.attr 'boolean', defaultValue: true
  cors_request_headers: DS.attr 'string'
  cors_max_age: DS.attr 'number', defaultValue: 600
  proxy_endpoints: DS.hasMany 'proxy-endpoint', async: true
  environments: DS.hasMany 'environment', async: true
  endpoint_groups: DS.hasMany 'endpoint-group', async: true
  remote_endpoints: DS.hasMany 'remote-endpoint', async: true
  hosts: DS.hasMany 'host', async: true
  libraries: DS.hasMany 'library', async: true

`export default Api`
