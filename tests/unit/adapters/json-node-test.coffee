`import { moduleForModel, test } from 'ember-qunit'`

moduleForModel 'json-node', 'Unit | Adapter | JsonNode',
  # Specify the other units that are required for this test.
  needs: ['adapter:json-node', 'serializer:json-node']

test 'it returns json-node instances from object-based query', (assert) ->
  store = @store()
  obj =
    strNode: 'A string!'
    nullNode: null
  store
    .query 'json-node', obj
    .then (records) ->
      assert.equal records.get('firstObject.type'), 'object'
      assert.equal records.get('firstObject.children.firstObject.type'), 'string'
      assert.equal records.get('firstObject.children.firstObject.name'), 'strNode'
      assert.equal records.get('firstObject.children.firstObject.value'), 'A string!'
      assert.equal records.get('firstObject.children.lastObject.type'), 'null'
      assert.equal records.get('firstObject.children.lastObject.name'), 'nullNode'

test 'it returns json-node instances from JSON string-based query', (assert) ->
  store = @store()
  obj =
    strNode: 'A string!'
    nullNode: null
  query = JSON.stringify obj
  store
    .query 'json-node', query
    .then (records) ->
      assert.equal records.get('firstObject.type'), 'object'
      assert.equal records.get('firstObject.children.firstObject.type'), 'string'
      assert.equal records.get('firstObject.children.firstObject.name'), 'strNode'
      assert.equal records.get('firstObject.children.firstObject.value'), 'A string!'
      assert.equal records.get('firstObject.children.lastObject.type'), 'null'
      assert.equal records.get('firstObject.children.lastObject.name'), 'nullNode'
