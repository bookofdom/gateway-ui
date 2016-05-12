`import { moduleForModel, test } from 'ember-qunit'`

testCase1 =
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

# Testing nested objects
testCase2 =
  title: 'Person'
  type: 'object'
  description: 'A person class'
  required: []
  properties:
    firstName:
      type: 'string'
    lastName:
      type: 'string'
    address:
      type: 'object'
      title: 'Address'
      description: "A person's address"
      required: []
      properties:
        streetAddress:
          type: 'string'
        city:
          type: 'string'
        state:
          type: 'string'
        country:
          type: 'string'
        zip:
          type: 'string'

# Testing all serializable attributes by type.
testCase3 =
  title: 'Example Schema'
  type: 'object'
  description: 'An example schema'
  additionalProperties: false
  patternProperties:
    '^S_':
      type: 'string'
    '^I_':
      type: 'integer'
    '^N_':
      type: 'number'
    '^A_':
      type: 'array'
    '^O_':
      type: 'object'
      required: []
  properties:
    name:
      type: 'string'
      title: 'Name'
      description: 'A name'
      pattern: '^(\\([0-9]{3}\\))?[0-9]{3}-[0-9]{4}$'
      minLength: 1
      maxLength: 10
    age:
      type: 'integer'
      title: 'Age'
      description: 'An age'
      multipleOf: 1.0
      minimum: 0
      maximum: 100
      exclusiveMinimum: true
      exclusiveMaximum: true
    size:
      type: 'number'
      title: 'Size'
      description: 'A size'
      multipleOf: 5.0
      minimum: 5
      maximum: 55
      exclusiveMinimum: true
      exclusiveMaximum: true
    friends:
      type: 'array'
      title: 'Friends'
      description: 'A list of friends'
      minItems: 1
      maxItems: 100
      uniqueItems: true
      items: [
        type: 'string'
      ,
        type: 'integer'
      ]
    phoneNumber:
      type: 'object'
      title: 'Phone Number'
      description: 'A phone number'
      minProperties: 1
      maxProperties: 10
      patternProperties:
        '^(\\([0-9]{3}\\))?[0-9]{3}-[0-9]{4}$':
          type: 'string'
      properties:
        zip:
          type: 'string'
      required: []
  required: ['name', 'age', 'size', 'friends', 'phoneNumber']

moduleForModel 'json-schema-node', 'Unit | Serializer | JsonSchemaNode',
  # Specify the other units that are required for this test.
  needs: ['model:proxy-endpoint-schema', 'serializer:json-schema-node']

test 'it serializes records', (assert) ->
  record = @subject()
  serializedRecord = record.serialize()
  assert.ok serializedRecord

test 'it normalizes a simple JSON schema', (assert) ->
  store = @store()
  serializer = store.serializerFor 'json-schema-node'
  data = Ember.copy testCase1, true
  normalized = serializer.normalize store.modelFor('json-schema-node'), data

  expected =
    data:
      attributes:
        title: 'Example Schema'
        type: 'object'
      id: null
      relationships:
        children:
          data: [
            name: 'job|occupation'
            pattern_name: true
            type: 'string'
          ,
            name: 'firstName'
            required: true
            type: 'string'
          ,
            description: 'Age in years'
            minimum: 0
            name: 'age'
            required: true
            type: 'integer'
          ,
            minItems: 1
            name: 'nickNames'
            type: 'array'
            uniqueItems: true
            children: [
              pattern: '[ws]*'
              type: 'string'
            ]
          ]
        parent:
          data: null
      type: 'json-schema-node'

  assert.deepEqual normalized, expected

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

    assert.deepEqual serialized, testCase1

test 'it serializes a nested JSON schema node', (assert) ->
  store = @store()
  serializer = store.serializerFor 'json-schema-node'
  Ember.run ->
    # model-based representation of above schema
    record = store.createRecord 'json-schema-node',
      title: 'Person'
      description: 'A person class'
      type: 'object'
      children: [
        store.createRecord 'json-schema-node',
          name: 'firstName'
          type: 'string'
        store.createRecord 'json-schema-node',
          name: 'lastName'
          type: 'string'
        store.createRecord 'json-schema-node',
          name: 'address'
          description: "A person's address"
          type: 'object'
          title: 'Address'
          children:[
            store.createRecord 'json-schema-node',
              name: 'streetAddress'
              type: 'string'
            store.createRecord 'json-schema-node',
              name: 'city'
              type: 'string'
            store.createRecord 'json-schema-node',
              name: 'state'
              type: 'string'
            store.createRecord 'json-schema-node',
              name: 'country'
              type: 'string'
            store.createRecord 'json-schema-node',
              name: 'zip'
              type: 'string'
          ]
      ]

    serialized = record.serialize()

    assert.deepEqual serialized, testCase2

test 'it serializes a JSON schema node with attributes by type', (assert) ->
  store = @store()
  serializer = store.serializerFor 'json-schema-node'
  Ember.run ->
    # model-based representation of above schema
    record = store.createRecord 'json-schema-node',
      title: 'Example Schema'
      description: 'An example schema'
      type: 'object'
      additional_properties: false
      children: [
        store.createRecord 'json-schema-node',
          name: '^S_'
          pattern_name: true
          type: 'string'
        store.createRecord 'json-schema-node',
          name: '^I_'
          pattern_name: true
          type: 'integer'
        store.createRecord 'json-schema-node',
          name: '^N_'
          pattern_name: true
          type: 'number'
        store.createRecord 'json-schema-node',
          name: '^A_'
          pattern_name: true
          type: 'array'
        store.createRecord 'json-schema-node',
          name: '^O_'
          pattern_name: true
          type: 'object'
        store.createRecord 'json-schema-node',
          name: 'name'
          type: 'string'
          title: 'Name'
          description: 'A name'
          pattern: '^(\\([0-9]{3}\\))?[0-9]{3}-[0-9]{4}$'
          min_length: 1
          max_length: 10
          required: true
        store.createRecord 'json-schema-node',
          name: 'age'
          title: 'Age'
          description: 'An age'
          type: 'integer'
          minimum: 0
          maximum: 100
          multiple_of: 1.0
          exclusive_minimum: true
          exclusive_maximum: true
          required: true
        store.createRecord 'json-schema-node',
          name: 'size'
          title: 'Size'
          description: 'A size'
          type: 'number'
          minimum: 5
          maximum: 55
          multiple_of: 5.0
          exclusive_minimum: true
          exclusive_maximum: true
          required: true
        store.createRecord 'json-schema-node',
          name: 'friends'
          type: 'array'
          title: 'Friends'
          description: 'A list of friends'
          min_items: 1
          max_items: 100
          unique_items: true
          required: true
          children: [
            store.createRecord 'json-schema-node',
              type: 'string'
          ,
            store.createRecord 'json-schema-node',
              type: 'integer'
          ]
        store.createRecord 'json-schema-node',
          name: 'phoneNumber'
          type: 'object'
          title: 'Phone Number'
          description: 'A phone number'
          min_properties: 1
          max_properties: 10
          required: true
          children: [
            store.createRecord 'json-schema-node',
              name: 'zip'
              type: 'string'
            store.createRecord 'json-schema-node',
              name: '^(\\([0-9]{3}\\))?[0-9]{3}-[0-9]{4}$'
              pattern_name: true
              type: 'string'
          ]
      ]

    serialized = record.serialize()

    assert.deepEqual serialized, testCase3
