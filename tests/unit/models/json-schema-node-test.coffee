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
  assert.notOk model.get('pattern_name')
  assert.notOk model.get('required')
  assert.notOk model.get('unique_items')
  assert.notOk model.get('exclusive_minimum')
  assert.notOk model.get('exclusive_maximum')

test '`types` array includes `object array null boolean integer number string`', (assert) ->
  model = @subject()
  modelClass = model.constructor
  types = modelClass.types.map (type) -> type.value
  assert.deepEqual types, 'object array null boolean integer number string'.split(' ')

test '`isRoot` returns true only for top-level nodes', (assert) ->
  store = @store()
  Ember.run ->
    # only top-level
    rootNode = store.createRecord 'json-schema-node',
      type: 'object'
      children: [
        store.createRecord 'json-schema-node',
          name: 'strField'
          type: 'string'
        store.createRecord 'json-schema-node',
          name: 'arrField'
          children: [
            store.createRecord 'json-schema-node',
              type: 'string'
          ]
      ]
    assert.equal rootNode.get('isRoot'), true
    assert.equal rootNode.get('children.firstObject.isRoot'), false
    assert.equal rootNode.get('children.lastObject.isRoot'), false
    assert.equal rootNode.get('children.lastObject.children.firstObject.isRoot'), false

test 'it can represent a simple JSON schema', (assert) ->
  store = @store()

  # Example JSON schema serialization of the model-based
  # representation (see below).
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

  Ember.run ->
    # model-based representation of above schema
    rootNode = store.createRecord 'json-schema-node',
      title: 'Example Schema'
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
    assert.equal rootNode.get('title'), 'Example Schema'
    assert.equal rootNode.get('type'), 'object'
    assert.equal rootNode.get('children.length'), 4
    assert.equal rootNode.get('children.firstObject.name'), 'firstName'
    assert.equal rootNode.get('children').objectAt(1).get('name'), 'age'
    assert.equal rootNode.get('children').objectAt(2).get('pattern_name'), true
    assert.equal rootNode.get('children.lastObject.name'), 'nickNames'
    assert.equal rootNode.get('children.lastObject.children.firstObject.pattern'), '[\w\s]*'
