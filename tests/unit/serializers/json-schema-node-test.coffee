`import { moduleForModel, test } from 'ember-qunit'`

jsonSchema =
  title: 'Example Schema'
  type: 'object'
  # `children` are serialized as `properties` or `patternProperties` for `object` type nodes.
  patternProperties:
    'job|occupation':
      type: 'string'
  properties:
    # Children of an object are serialized as key/value pairs,
    # where `name` is the key and the value is... the serialized child.
    firstName:
      type: 'string'
    age:
      description: 'Age in years'
      type: 'integer'
      minimum: 0
    nickNames:
      type: 'array'
      uniqueItems: true
      minItems: 1
      # `children` are serialized to `items` for `array` type nodes.
      # Unlike children of an object, there are no key/value pairs.
      # Only one child is expected.  And the (only) child's serialization is
      # assigned directly to `items`.
      items:
        type: 'string'
        pattern: '[\w\s]*'
  # In JSON schema, required fields are expressed in their own array!
  # Exactly where you'd expect to find them!
  required: [
    'firstName'
    'age'
  ]

moduleForModel 'json-schema-node', 'Unit | Serializer | JsonSchemaNode',
  # Specify the other units that are required for this test.
  needs: ['serializer:json-schema-node']

test 'it normalizes a simple JSON schema', (assert) ->
  expect 0
  store = @store()
  serializer = store.serializerFor 'json-schema-node'
  # normalize method currently fails
  # normalized = serializer.normalize 'json-schema-node', jsonSchema

test 'it serializes a simple JSON schema node', (assert) ->
  store = @store()
  serializer = store.serializerFor 'json-schema-node'
  Ember.run ->
    # model-based representation of above schema
    record = store.createRecord 'json-schema-node',
      title: 'Example Schema'
      type: 'object'
      children: [
        store.createRecord 'json-schema-node',
          name: 'firstName'
          type: 'string'
          required: true
        store.createRecord 'json-schema-node',
          name: 'age'
          description: 'Age in years'
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

    serialized = record.serialize()

    assert.deepEqual serialized, jsonSchema
