`import Ember from 'ember'`
`import DS from 'ember-data'`
`import Model from 'gateway/pods/model/model'`

ProxyEndpointSchema = Model.extend
  name: DS.attr 'string'
  request_schema_type: DS.attr 'string', defaultValue: 'json_schema'
  request_schema: DS.attr 'string', defaultValue: '{}'
  response_same_as_request: DS.attr 'boolean', defaultValue: false
  response_schema_type: DS.attr 'string', defaultValue: 'json_schema'
  response_schema: DS.attr 'string', defaultValue: '{}'
  # Request and response schemas always serialize into the string fields
  # above, `request_schema` and `response_schema`.  Their contents may come from
  # either themselves or from the JSON schema node relationships below.  Mark
  # either or both of the following booleans as `true` to serialize from the
  # JSON schema node relationships.
  # See serializer for more information.
  serialize_request_json_schema: false
  serialize_response_json_schema: false

  # Relationships
  proxy_endpoint: DS.belongsTo 'proxy-endpoint', async: true
  request_json_schema: DS.belongsTo 'json-schema-node',
    async: false
    stains: true
    embeddedModel: true
    inverse: 'proxy_endpoint_schema_request_parent'
  response_json_schema: DS.belongsTo 'json-schema-node',
    async: false
    stains: true
    embeddedModel: true
    inverse: 'proxy_endpoint_schema_response_parent'

`export default ProxyEndpointSchema`
