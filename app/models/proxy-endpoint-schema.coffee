`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Model from 'gateway/models/model'`

ProxyEndpointSchema = Model.extend
  name: DS.attr 'string'
  request_schema_type: DS.attr 'string', defaultValue: 'json_schema'
  request_schema: DS.attr 'string'
  response_same_as_request: DS.attr 'boolean', defaultValue: false
  response_schema_type: DS.attr 'string', defaultValue: 'json_schema'
  response_schema: DS.attr 'string'

  # Relationships
  proxy_endpoint: DS.belongsTo 'proxy-endpoint', async: true

`export default ProxyEndpointSchema`
