`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'json-schema-node', 'Unit | Model | JsonSchemaNode',
  # Specify the other units that are required for this test.
  needs: []

test 'it exists', (assert) ->
  model = @subject()
  store = @store()
  assert.ok !!model

test '`type` field defaults to `object`', (assert) ->
  model = @subject()
  assert.equal model.get('type'), 'object'

test 'boolean fields default to `false`', (assert) ->
  model = @subject()
  assert.notOk model.get('root')
  assert.notOk model.get('patternName')
  assert.notOk model.get('required')
  assert.notOk model.get('uniqueItems')
  assert.notOk model.get('exclusiveMinimum')
  assert.notOk model.get('exclusiveMaximum')

test '`types` array includes `object array null boolean integer number string`', (assert) ->
  model = @subject()
  modelClass = model.constructor
  types = modelClass.types.map (type) -> type.value
  assert.deepEqual types, 'object array null boolean integer number string'.split(' ')

test 'it can represent a simple JSON schema', (assert) ->
  store = @store()

  # Example JSON schema serialization of the model-based
  # representation (see below).
  jsonSchema =
    title: 'Example Schema'
    type: 'object'
    # `children` are serialized as `properties` for `object` type nodes.
    properties:
      # Children of an object are serialized as key/value pairs in the
      # serialization, where `name` is the key and the value is...
      # the serialized child-sans-name.
      name:
        type: 'string'
      age:
        description: 'Age in years'
        type: 'integer'
        minimum: 0
      nickNames:
        type: 'array'
        uniqueItems: true
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

  root = null
  Ember.run ->
    # model-based representation of above schema
    root = store.createRecord 'json-schema-node',
      title: 'Example Schema'
      root: true
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
          name: 'nickNames'
          type: 'array'
          minItems: 1
          uniqueItems: true
          children: [
            store.createRecord 'json-schema-node',
              type: 'string'
              pattern: '[\w\s]*'
          ]
      ]
    assert.equal root.get('title'), 'Example Schema'
    assert.equal root.get('root'), true
    assert.equal root.get('type'), 'object'
    assert.equal root.get('children.length'), 3
    assert.equal root.get('children.firstObject.name'), 'firstName'
    assert.equal root.get('children').objectAt(1).get('name'), 'age'
    assert.equal root.get('children.lastObject.name'), 'nickNames'
    assert.equal root.get('children.lastObject.children.firstObject.pattern'), '[\w\s]*'
