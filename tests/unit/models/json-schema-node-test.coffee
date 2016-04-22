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
