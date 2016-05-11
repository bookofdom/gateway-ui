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
  request_json_schema: DS.belongsTo 'json-schema-node',
    async: false
    stains: true
    embedded: true
    inverse: 'proxy_endpoint_schema_request_parent'
  response_json_schema: DS.belongsTo 'json-schema-node',
    async: false
    stains: true
    embedded: true
    inverse: 'proxy_endpoint_schema_response_parent'

`export default ProxyEndpointSchema`
