`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'json-node', 'Unit | Model | JsonNode',
  # Specify the other units that are required for this test.
  needs: []

test 'it exists', (assert) ->
  model = @subject()
  store = @store()
  assert.ok !!model

test '`type` field defaults to `string`', (assert) ->
  model = @subject()
  assert.equal model.get('type'), 'string'

test '`types` array includes `object array null boolean number string`', (assert) ->
  model = @subject()
  modelClass = model.constructor
  types = modelClass.types.map (type) -> type.value
  assert.deepEqual types, 'object array null boolean number string'.split(' ')

test '`isRoot` returns true only for top-level nodes', (assert) ->
  store = @store()
  Ember.run ->
    # only top-level
    rootNode = store.createRecord 'json-node',
      type: 'object'
      children: [
        store.createRecord 'json-node',
          name: 'strField'
          type: 'string'
        store.createRecord 'json-node',
          name: 'arrField'
          type: 'array'
          children: [
            store.createRecord 'json-node',
              type: 'string'
          ]
      ]
    assert.equal rootNode.get('isRoot'), true
    assert.equal rootNode.get('children.firstObject.isRoot'), false
    assert.equal rootNode.get('children.lastObject.isRoot'), false
    assert.equal rootNode.get('children.lastObject.children.firstObject.isRoot'), false

test '`parentIsObject` returns true only if parent node is an object', (assert) ->
  store = @store()
  Ember.run ->
    rootNode = store.createRecord 'json-node',
      type: 'object'
      children: [
        store.createRecord 'json-node',
          name: 'strField'
          type: 'array'
          children: [
            store.createRecord 'json-node',
              type: 'string'
          ]
      ]
    assert.notOk rootNode.get('parentIsObject')
    assert.ok rootNode.get('children.firstObject.parentIsObject')
    assert.notOk rootNode.get('children.firstObject.children.firstObject.parentIsObject')

test '`canHaveChildren` returns true only if parent node is an object or an array', (assert) ->
  store = @store()
  Ember.run ->
    rootNode = store.createRecord 'json-node',
      type: 'object'
      children: [
        store.createRecord 'json-node',
          name: 'strField'
          type: 'array'
          children: [
            store.createRecord 'json-node',
              type: 'string'
          ]
      ]
    assert.ok rootNode.get('canHaveChildren')
    assert.ok rootNode.get('children.firstObject.canHaveChildren')
    assert.notOk rootNode.get('children.firstObject.children.firstObject.canHaveChildren')

test '`canHaveName` returns true only if parent node is an object', (assert) ->
  store = @store()
  Ember.run ->
    rootNode = store.createRecord 'json-node',
      type: 'object'
      children: [
        store.createRecord 'json-node',
          name: 'strField'
          type: 'array'
          children: [
            store.createRecord 'json-node',
              type: 'string'
          ]
      ]
    assert.notOk rootNode.get('canHaveName')
    assert.ok rootNode.get('children.firstObject.canHaveName')
    assert.notOk rootNode.get('children.firstObject.children.firstObject.canHaveName')

test '`canHaveValue` returns true only if node is both not an object and not an array', (assert) ->
  model = @subject()
  Ember.run ->
    model.set 'type', 'string'
    assert.ok model.get('canHaveValue')
    model.set 'type', 'number'
    assert.ok model.get('canHaveValue')
    model.set 'type', 'boolean'
    assert.ok model.get('canHaveValue')
    model.set 'type', 'null'
    assert.notOk model.get('canHaveValue')
    model.set 'type', 'array'
    assert.notOk model.get('canHaveValue')
    model.set 'type', 'object'
    assert.notOk model.get('canHaveValue')
