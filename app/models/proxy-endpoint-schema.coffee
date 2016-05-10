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

  request_json_schema: Ember.computed ->
    store = @get 'store'
    store.createRecord 'json-schema-node',
      title: 'Request Schema'
      type: 'object'
      children: [
        store.createRecord 'json-schema-node',
          name: 'firstName'
          type: 'string'
          required: true
        store.createRecord 'json-schema-node',
          name: 'age'
          type: 'integer'
          minimum: 0
          required: true
        store.createRecord 'json-schema-node',
          name: 'job|occupation'
          pattern_name: true
          type: 'string'
        store.createRecord 'json-schema-node',
          name: 'nickNames'
          type: 'array'
          min_items: 1
          unique_items: true
          children: [
            store.createRecord 'json-schema-node',
              type: 'string'
              pattern: '[\w\s]*'
          ]
      ]

  response_json_schema: Ember.computed ->
    store = @get 'store'
    store.createRecord 'json-schema-node',
      title: 'Response Schema'
      type: 'object'
      children: [
        store.createRecord 'json-schema-node',
          name: 'nickNames'
          type: 'array'
          min_items: 1
          unique_items: true
          children: [
            store.createRecord 'json-schema-node',
              type: 'string'
              pattern: '[\w\s]*'
          ]
      ]

`export default ProxyEndpointSchema`
